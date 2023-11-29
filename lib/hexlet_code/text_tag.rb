# frozen_string_literal: true

# HexletCode is a module that provides functionality for generating form elements.
module HexletCode
  autoload(:Tag, File.join(__dir__, 'tag.rb'))
  # The FormRenderer class renders a textarea based on the provided hash and block.
  class TextTag
    def self.build(options)
      cols_ta = options[:cols] ||= '20'
      rows_ta = options[:rows] ||= '40'
      ta_options = options.merge({ cols: cols_ta, rows: rows_ta })
      Tag.build('textarea', ta_options.except(:value)) { ta_options[:value] }
    end
  end
end
