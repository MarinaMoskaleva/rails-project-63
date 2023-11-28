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
        tag_name: get_tag_name(options),
        tag_options: get_tag_options(object_attr, options)
      }
      object_tag[:tag_block] = @object.public_send(object_attr) if get_tag_name(options) == 'textarea'
      @form[:tags_input].push(object_tag)
    end

    def submit(button_text = 'Save')
      @form[:tag_submit] = { tag_name: get_tag_name, tag_options: get_submit_options(button_text) }
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
      tag_value = @object.public_send(object_attr) || ''
      options = { name: object_attr.to_s }.merge(options)
      options = options.merge({ value: tag_value }) unless tag_name == 'textarea'
      options.except(:as)
    end

    def get_submit_options(btn_text)
      {
        type: 'submit',
        value: btn_text
      }
    end
  end
end
