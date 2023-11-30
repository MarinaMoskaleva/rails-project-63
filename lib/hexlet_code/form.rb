# frozen_string_literal: true

# HexletCode is a module that provides functionality for generating form elements.
module HexletCode
  # The Form class prepares an array for rendering form
  class Form
    attr_reader :form

    def initialize(object, options)
      @object = object
      form_options = options.except(:url, :method)
      form_options[:action] = options.fetch(:url, '#')
      form_options[:method] = options.fetch(:method, 'post')
      @form =
        {
          tag_form: { tag_name: 'form', tag_options: form_options },
          tags_input: [],
          tag_submit: {}
        }
    end

    def input(object_attr, options = {})
      raise NoMethodError, "undefined method #{object_attr} for #{@object}" unless @object.respond_to?(object_attr)

      object_tag = {
        tag_name: options.fetch(:as, :input).to_s,
        tag_options: get_tag_options(object_attr, options)
      }
      @form[:tags_input].push(object_tag)
    end

    def submit(button_text = 'Save', options = {})
      @form[:tag_submit] = { tag_name: 'input', tag_options: get_submit_options(button_text, options) }
    end

    private

    def get_tag_options(object_attr, options)
      tag_value = options[:value] || @object.public_send(object_attr) || ''
      options = { name: object_attr.to_s }.merge(options)
      options = options.merge({ value: tag_value })
      options.except(:as)
    end

    def get_submit_options(btn_text, options)
      { type: 'submit', value: btn_text }.merge(options)
    end
  end
end
