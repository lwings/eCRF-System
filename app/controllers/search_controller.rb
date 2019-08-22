class SearchController < ApplicationController
  # before_action :authenticate_user!
  helper_method :sort_column, :sort_direction
  # before_action :get_available_research_groups
  def index
    # authorize! :read, Patient

    @q = Patient.ransack(params[:q])
    return unless params[:q].present?
    #@q.sorts = 'updated_at desc' if @q.sorts.empty?
    # @research_groups = @project.research_groups.all
    # p @research_groups
    @patients = @q.result(distinct: true)
    # @patients = @q.result.accessible_by(current_ability, :read).uniq
    respond_to do |format|
      format.html { @patients = @patients.order("#{sort_column} #{sort_direction}").page(params[:page]) }
      format.json { @patients = @patients.page(params[:page]) }
      format.csv do
        # authorize! :export, Patient
        EventLog.create({user: current_user, center: current_user.center, event: :export})
        filename = "Query-#{Time.now.strftime('%Y%m%d%H%M%S')}.csv"
        send_csv (by_position ? export_by_position(export_tables) : export(export_tables)), filename
      end
    end

    # filter age, bmi
    # [:ages, :bmis].each { |key| array_arg_in_params(key) }
    #
    # @q = Patient.accessible_by(current_ability, :read).ransack(params[:q])
    # return unless params[:q].present?
    #
    # @q.build_grouping unless @q.groupings.empty?
    # @patients = @q.result.uniq
    # respond_to do |format|
    #   format.html { @patients = @patients.order("#{sort_column} #{sort_direction}").page(params[:page]) }
    #   format.csv do
    #     authorize! :export, Patient
    #     EventLog.create({user: current_user, center: current_user.center, event: :export})
    #     filename = "Query-#{Time.now.strftime('%Y%m%d%H%M%S')}.csv"
    #     send_csv Patient.to_csv(@patients, export_tables), filename
    #   end
    # end
  end

  def advance

    unless params[:q].present?
      @q = Patient.ransack(nil)
      render 'advance'
      return
    end

    ## remove nil/""/[""] params
    params[:q].reject! { |_, value| value.empty?||value==[""] }

    @q = Patient.accessible_by(current_ability, :read).ransack(params[:q])
    return unless params[:q].present?
    @patients = @q.result.uniq
    respond_to do |format|
      format.html {
        @patients = @patients.order("#{sort_column} #{sort_direction}").page(params[:page])
        render '_result'
      }
      format.csv do
        # authorize! :export, Patient
        EventLog.create({user: current_user, center: current_user.center, event: :export})
        filename = "Query-#{Time.now.strftime('%Y%m%d%H%M%S')}.csv"
        send_csv export(export_tables), filename
      end
    end
  end

  def new_advance

    unless params[:q].present?
      @q = Patient.ransack(nil)
      render 'new_advance'
      return
    end

    ## remove nil/""/[""] params
    params[:q].reject! { |_, value| value.empty?||value==[""] }


    @q = Patient.accessible_by(current_ability, :read).search(params[:q])
    @patients = @q.result.uniq
    @q.build_grouping unless @q.groupings.any?
    @q.build_condition if @q.conditions.empty?
    respond_to do |format|
      format.html {
        @patients = @patients.order("#{sort_column} #{sort_direction}").page(params[:page])
        render '_result'
      }

      format.csv do
        # authorize! :export, Patient
        EventLog.create({user: current_user, center: current_user.center, event: :export})
        filename = "Query-#{Time.now.strftime('%Y%m%d%H%M%S')}.csv"
        send_csv (by_position ? export_by_position(export_tables) : export(export_tables)), filename
      end
    end
  end

  def get_available_research_groups
    p :project_name
    @available_research_groups = @project.research_groups.all
  end

  def value_fields
    @selected = {option:params[:selected_id],id:params[:v_id],name:params[:v_name],object_name:params[:v_name][0..-14]}
    respond_to do |format|
      format.html {
        render '_value_fields', layout: false

      }
    end

  end

  private
  def sort_column(c = 'patients.created_at')
    Patient.column_names.include?(params[:sort]) ? params[:sort] : c
  end

  def sort_direction(d = 'desc')
    %w[asc desc].include?(params[:direction]) ? params[:direction] : d
  end

  ## array of symbols
  def export_tables
    params[:export][:table].present? ? params[:export][:table] & Export::EXPORT_TABLE_NAMES : Export::EXPORT_TABLE_NAMES
  end

  def by_position
    params[:export][:by_position] == '1'
  end

  def send_csv(csv, filename)
    send_data csv, :type => 'text/csv; header=present', :filename => filename
  end

  # TODO: improve
  def export(tables)
    col_sep, row_sep = ',' , "\n"

    _tables = tables.dup
    tables_for_header = tables.dup

    index = tables_for_header.find_index('operation')
    tables_for_header.insert(index + 1, 'operation_lesions') unless index.nil?

    special = 'followups'
    if _tables.include? special
      _tables.delete special
      Export::EXPORT_LIMIT[special.to_sym].times do |t|
        _tables << "#{special.singularize}_#{t}"
      end
    end

    les = 'operation_lesions'
    index = _tables.find_index('operation')
    if index
      Export::EXPORT_LIMIT[les.to_sym].times do |t|
        _tables.insert index+t+1, "#{les.singularize}_#{t}"
      end
    end

    # Join version, similar performance, why?
    @patients.joins(:export_cache).select(_tables.map{ |t| "export_caches.#{t}" }.join(','))
        .each_with_object("\ufeff" + Export.header_for_export(tables_for_header).to_csv(row_sep: row_sep)) do |p, csv|
      csv.concat p.attributes.values_at(*_tables).join(col_sep).concat(row_sep)
    end

    # Traverse version
    # @patients.each_with_object("\ufeff" + Export.header_for_export(tables).to_csv(row_sep: row_sep)) do |p, csv|
    #   csv.concat p.export_cache.attributes.values_at(*_tables).join(col_sep).concat(row_sep)
    # end
  end

  ## export by operation lesion breast position
  # TODO: low efficiency
  def export_by_position(tables)
    col_sep, row_sep = ',' , "\n"

    tbl = tables.dup

    tbl_tail = tbl & %w(adjuvant followups)
    tbl_head = tbl - tbl_tail

    special = 'followups'
    if tbl.include? special
      tbl.delete special
      tbl_tail.delete special
      Export::EXPORT_LIMIT[special.to_sym].times do |t|
        tbl_tail << "#{special.singularize}_#{t}"
        tbl << tbl_tail.last
      end
    end

    les, tbl_les = 'operation_lesions', []
    if tbl_head.include? 'operation'
      Export::EXPORT_LIMIT[les.to_sym].times do |t|
        tbl_les << "#{les.singularize}_#{t}"
        tbl << tbl_les.last
      end
    end

    empty_row, header = if tbl_les.empty?
                          [nil, Export.header_for_export(tables)]
                        else
                          [Array.new(OperationLesion.columns_for_export.size).to_csv(row_sep: nil),
                           Export.header_for_export(tbl_head) + ['手术.是否双乳病灶'] +
                               Export.header_for_export([les], true, operation_lesions: 2 ) + Export.header_for_export(tables & %w(adjuvant followups))]
                        end

    # Join version, similar performance, why?
    @patients.joins(:export_cache).select(tbl.map{ |t| "export_caches.#{t}" }.join(','))
        .each_with_object("\ufeff" + header.to_csv(row_sep: row_sep)) do |p, csv|
      row_head, row_les, row_tail = [tbl_head, tbl_les, tbl_tail].map{|tbl| p.attributes.values_at(*tbl) }

      if tbl_les.empty?
        csv.concat (row_head + row_tail).join(col_sep).concat(row_sep)
      else
        index = (OperationLesion.attribute_names - OperationLesion::EXPORT_IGNORED_COLUMNS).find_index('position')
        left, right = [:left, :right].map{|pos| OperationLesion.position.find_value(pos).text }
        hsh = {left => :left, right => :right}
        row_les_split = row_les.each_with_object({left: [], right: []}) do |r, obj|
          obj[hsh[r.split(',', index+2)[index]]].try(:<<, r)
        end

        row_les_split[:left] = row_les_split[:left].first(2)
        row_les_split[:right] = row_les_split[:right].first(2)

        is_double = !row_les_split.values.any?(&:empty?)

        if row_les_split.values.all?(&:empty?)
          csv.concat (row_head + [nil] + [empty_row]*2 + row_tail).join(col_sep).concat(row_sep)
        else
          row_les_split.each_value do |les|
            unless les.size == 0
              while les.size < 2
                les << empty_row
              end
              csv.concat (row_head + [is_double.to_s] + les + row_tail).join(col_sep).concat(row_sep)
            end
          end
        end
      end
    end
  end
end
