# frozen_string_literal: true

require_relative 'hexlet_code/version'

# HexletCode is a module that provides functionality for generating form elements.
module HexletCode
  autoload(:Tag, File.join(__dir__, 'tag.rb'))
  autoload(:FormBuilder, File.join(__dir__, 'form_builder.rb'))

  def self.form_for(object, options = {})
    form_tags = options.except(:url, :method)
    form_tags[:action] = options.fetch(:url, '#')
    form_tags[:method] = options.fetch(:method, 'post')
    form = FormBuilder.new(object)
    yield form
    Tag.build('form', form_tags) { form.result }
  end
end
