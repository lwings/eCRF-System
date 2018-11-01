module SimpleForm
  module Components
    module Errors
      def error(wrapper_options = nil)
        if has_errors?
          error_text
        else
          options[:front_error]
        end
      end
    end
  end


  class FormBuilder
    def multiple_input(attribute_name, options = {})
      input(attribute_name, options) do
        input_field 'has_' + attribute_name.to_s, as: :select
        input_field attribute_name, as: :check_boxes
        label 'ex_' + attribute_name.to_s
        input_field 'ex' + attribute_name.to_s
      end

    end
  end
end


module Enumerize
  class Value
    def i18n_keys
      @i18n_keys ||= begin
        i18n_keys = i18n_scopes
        i18n_keys << [:"enumerize.defaults.#{@attr.name}.#{self}"]
        i18n_keys << [:"enumerize.#{@attr.name}.#{self}"]
        i18n_keys << self # humanize value if there are no translations !!cancel this
        i18n_keys.flatten
      end
    end
  end
  class Attribute
    def value_options(options = {})
      values = if options.empty?
                 @values
               else
                 raise ArgumentError, 'Options cannot have both :only and :except' if options[:only] && options[:except]

                 only = Array(options[:only]).map(&:to_s)
                 except = Array(options[:except]).map(&:to_s)

                 @values.reject do |value|
                   if options[:only]
                     !only.include?(value)
                   elsif options[:except]
                     except.include?(value)
                   end
                 end
               end

      values.map { |v| [v.text, v.value.to_s] }#TODO v.text??
    end
  end
end

module FlagShihTzu
  def options(colmn = DEFAULT_COLUMN_NAME, *args)
    flags_to_collect = args.empty? ? all_flags(colmn) : args
    collect_flags(*flags_to_collect) do |memo, flag|
      memo << [I18n.t(flag, scope: ['flag_shih_tzu', self.class.name.underscore, colmn], default: flag.to_s), flag]
    end
  end

  def selected_options(colmn = DEFAULT_COLUMN_NAME, *args)
    flags_to_collect = args.empty? ? selected_flags(colmn) : args
    collect_flags(*flags_to_collect) do |memo, flag|
      memo << I18n.t(flag, scope: ['flag_shih_tzu', self.class.name.underscore, colmn], default: flag.to_s)
    end
  end
end

module ActionView
  module Helpers
    module DateHelper
      def date_select(object_name, method, options = {}, html_options = {})
        options[:start_year] ||= 1995
        options[:end_year] ||= Date.today.year
        options[:include_blank] ||= true
        Tags::DateSelect.new(object_name, method, self, options, html_options).render
      end
    end
  end
end

module SimpleForm
  module Inputs
    class NumericInput < Base
      enable :placeholder, :min_max

      def input(wrapper_options = nil)
        input_html_classes.unshift("numeric")
        if html5?
          input_html_options[:type] ||= "number"
          input_html_options[:step] ||= integer? ? 1 : "any"
          input_html_options[:min] ||= 0
        end

        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

        @builder.text_field(attribute_name, merged_input_options)
      end
    end
  end
end
