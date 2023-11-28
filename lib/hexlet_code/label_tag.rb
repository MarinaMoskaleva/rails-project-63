# frozen_string_literal: true

# HexletCode is a module that provides functionality for generating form elements.
module HexletCode
  autoload(:Tag, File.join(__dir__, 'tag.rb'))
  # The LabelTag class renders a label based on the provided value.
  class LabelTag
    def self.build(value)
      Tag.build('label', { for: value }) { value.capitalize }
    end
  end
end
