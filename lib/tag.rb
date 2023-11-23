# frozen_string_literal: true

module HexletCode
  # The `Tag` class within the HexletCode module provides functionality for generating HTML tags.
  class Tag
    def self.build(tag_name, options = {})
      attributes = options.map { |key, value| " #{key}=\"#{value}\"" }.join
      rez = "<#{tag_name}#{attributes}>"
      if block_given?
        rez += yield
        rez += "</#{tag_name}>"
      elsif %w[div textarea].include? tag_name
        rez += "</#{tag_name}>"
      end
      rez
    end
  end
end
