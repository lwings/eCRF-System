module ApplicationHelper
  def vt(key, options={})
    options[:scope] ||= 'views'
    I18n.t(key, options)
  end

  def fe(key)
    I18n.t(key, scope: 'form_errors')
  end

  def empt(str, opt)
    (str.nil?||str.try(:empty?)) ? opt : str
  end

  def sort_link(column, model)
    css_class = column.to_s == sort_column ? "current #{sort_direction} sort" : 'sort'
    direction = column.to_s == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'

    # the order of merge is important
    link_to model.human_attribute_name(column), params.merge({:sort => column, :direction => direction}), {:class => css_class}
  end

  def pair_display_for(object, &block)
    display = PairDisplay.new(object, self)
    capture(display, &block)
  end

  class PairDisplay
    def initialize(object, template)
      @object = object
      @klass = object.class
      @template = template
      @config = {
          s2: {wrapper_class: 'column small-2' },
          s3: {wrapper_class: 'column small-3' },
          s4: {wrapper_class: 'column small-4' },
          s5: {wrapper_class: 'column small-5' },
          s6: {wrapper_class: 'column small-6' },
          s9: {wrapper_class: 'column small-9'},
          s6_v: {wrapper_class: 'column small-6' },
          s12_v: {wrapper_class: 'column small-12' },
      }
    end

    def nested_for(nested, &block)
      display = PairDisplay.new(@object.send(nested), @template)
      @template.capture(display, &block)
    end

    def pair(attr_name, config = :s3)
      pair_raw(attr_name, @object.send(attr_name), config)
    end

    def pair_raw(key, val, config = :s3,  key_class = 'pair-key', value_class = 'pair-value')
      config = @config[config]

      direction = config[:direction] || :vertical

      content = @template.content_tag('span', @klass.human_attribute_name(key), class: key_class) +
          @template.content_tag('span', val, class: value_class)
      @template.content_tag('div',
                            @template.content_tag('div', content, class: ['pair', direction]),
                            class: config[:wrapper_class])
    end
  end
end
