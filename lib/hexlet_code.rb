# frozen_string_literal: true

require_relative "hexlet_code/version"
require_relative "tag"
# HexletCode is a module that provides functionality for generating form elements.
module HexletCode
  class Error < StandardError; end
  autoload(:Tag, File.expand_path(__dir__, "tag.rb"))
  # The FormBuilder class facilitates the step-by-step construction of an HTML form
  # based on provided data objects, automatically generating HTML code for input fields and text areas.
  class FormBuilder
    attr_accessor :object, :rez

    def initialize(object)
      @object = object
      @rez = ""
    end

    def input(attr, options = {})
      raise NoMethodError, "undefined method #{attr} for #{@object}" unless @object.public_send(attr)

      tag_name = get_tag_name(options)
      tag_options = get_tag_options(attr, options)
      @rez += Tag.build(tag_name, tag_options) { @object.public_send(attr) } if tag_name == "textarea"
      @rez += Tag.build(tag_name, tag_options) if tag_name != "textarea"
    end

    private

    def get_tag_name(options)
      tag_name = :input
      if options[:as]
        tag_name = options[:as] == :text ? :textarea : options[:as]
      end
      tag_name.to_s
    end

    def get_tag_options(attr, options)
      tag_name = get_tag_name(options)
      options = textarea_options(options) if tag_name == "textarea"
      options = input_options(attr, options) if tag_name == "input"
      options = default_options(attr, options)
      options.reject { |key, _| key == :as }
    end

    def textarea_options(options)
      cols = options[:cols] ||= "20"
      rows = options[:rows] ||= "40"
      { cols: cols, rows: rows }.merge(options)
    end

    def input_options(attr, options)
      type = options[:type] ||= "text"
      { type: type, value: @object.public_send(attr) }.merge(options)
    end

    def default_options(attr, options)
      { name: attr.to_s }.merge(options)
    end
  end

  def self.form_for(user, options = {})
    action = options.fetch(:url, "#")
    form = FormBuilder.new(user)
    yield form
    "<form action=\"#{action}\" method=\"post\">#{form.rez}</form>"
  end
end
