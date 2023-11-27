# frozen_string_literal: true

module HexletCode
  # The FormRenderer class renders a form based on the provided array.
  class FormRenderer
    def initialize(form)
      @form = form
    end

    def render
      @form[:tags].map do |item|
        tag_block = item.fetch(:tag_block, '')
        Tag.build(item[:tag_name], item[:tag_options]) { tag_block }
      end.join
    end
  end
end
