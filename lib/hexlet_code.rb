# frozen_string_literal: true

require_relative "hexlet_code/version"
# HexletCode is a module that provides functionality for generating form elements.
module HexletCode
  class Error < StandardError; end
  autoload(:Tag, File.expand_path("./lib/tag.rb"))
end
