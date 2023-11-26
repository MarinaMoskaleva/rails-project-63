# frozen_string_literal: true

module HexletCode
  # The FormBuilder class facilitates the step-by-step construction of an HTML form
  # based on provided data objects, automatically generating HTML code for input fields and text areas.
  class FormBuilder
    attr_accessor :result

    def initialize(object)
      @object = object
      @result = ''
    end

    def input(object_attr, options = {})
      raise NoMethodError, "undefined method #{object_attr} for #{@object}" unless @object.respond_to?(object_attr)

      tag_name = get_tag_name(options)
      tag_options = get_tag_options(object_attr, options)
      @result += Tag.build('label', for: object_attr.to_s) { object_attr.to_s.capitalize }
      case tag_name
      when 'textarea'
        @result += Tag.build(tag_name, tag_options) { @object.public_send(object_attr) }
      when 'input'
        @result += Tag.build(tag_name, tag_options)
      end
    end

    def submit(button_text = 'Save')
      tag_name = get_tag_name
      tag_options = get_submit_options(button_text)
      @result += Tag.build(tag_name, tag_options)
    end

    private

    def get_tag_name(options = {})
      tag_name = :input
      if options[:as]
        tag_name = options[:as] == :text ? :textarea : options[:as]
      end
      tag_name.to_s
    end

    def get_tag_options(object_attr, options)
      tag_name = get_tag_name(options)
      options = textarea_options(options) if tag_name == 'textarea'
      options = input_options(object_attr, options) if tag_name == 'input'
      options = default_options(object_attr, options)
      options.except(:as)
    end

    def textarea_options(options)
      cols_ta = options[:cols] ||= '20'
      rows_ta = options[:rows] ||= '40'
      { cols: cols_ta, rows: rows_ta }.merge(options)
    end

    def input_options(object_attr, options)
      input_type = options[:type] ||= 'text'
      input_value = @object.public_send(object_attr) || ''
      { type: input_type, value: input_value }.merge(options)
    end

    def default_options(object_attr, options)
      { name: object_attr.to_s }.merge(options)
    end

    def get_submit_options(btn_text)
      {
        type: 'submit',
        value: btn_text
      }
    end
  end
end
