# frozen_string_literal: true

# HexletCode is a module that provides functionality for generating form elements.
module HexletCode
  autoload(:Tag, File.join(__dir__, 'tag.rb'))
  # The InputTag class renders an input based on the provided hash.
  class InputTag
    def self.build(options)
      input_type = options[:type] ||= 'text'
      input_value = options[:value] || ''
      input_options = options.merge({ type: input_type, value: input_value })
      Tag.build('input', input_options)
    end
  end
end
