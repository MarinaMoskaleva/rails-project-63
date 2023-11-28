# frozen_string_literal: true

module HexletCode
  SELF_CLOSING_TAGS = %w[img br hr input].freeze
  # The `Tag` class within the HexletCode module provides functionality for generating HTML tags.
  class Tag
    def self.build(tag_name, options = {})
      attributes = options.map { |key, value| " #{key}=\"#{value}\"" }.join
      result = "<#{tag_name}#{attributes}>"
      return result if SELF_CLOSING_TAGS.include? tag_name

      result + yield + "</#{tag_name}>"
    end
  end
end
