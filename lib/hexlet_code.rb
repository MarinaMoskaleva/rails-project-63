# frozen_string_literal: true

require_relative 'hexlet_code/version'

# HexletCode is a module that provides functionality for generating form elements.
module HexletCode
  autoload(:Form, File.join(__dir__, 'hexlet_code/form.rb'))
  autoload(:FormBuilder, File.join(__dir__, 'hexlet_code/form_builder.rb'))

  def self.form_for(object, options = {})
    form = Form.new(object, options)
    yield form
    FormBuilder.render(form.form)
  end
end
