# frozen_string_literal: true

# HexletCode is a module that provides functionality for generating form elements.
module HexletCode
  autoload(:LabelTag, File.join(__dir__, 'label_tag.rb'))
  autoload(:InputTag, File.join(__dir__, 'input_tag.rb'))
  autoload(:TextareaTag, File.join(__dir__, 'textarea_tag.rb'))
  autoload(:FormTag, File.join(__dir__, 'form_tag.rb'))
  # The FormBuilder class renders a form based on the provided array.
  class FormBuilder
    def render(form)
      form_tag = form[:tag_form]
      input_fields = get_input_fields(form[:tags_input])
      submit_field = get_submit_field(form[:tag_submit])
      form_fields = input_fields + submit_field
      FormTag.build(form_tag[:tag_options], form_fields)
    end

    private

    def get_input_fields(tags_input)
      tags_input.map do |item|
        LabelTag.build(item[:tag_options][:name]) +
          case item[:tag_name]
          when 'input'
            InputTag.build(item[:tag_options])
          when 'textarea'
            TextareaTag.build(item[:tag_options], item.fetch(:tag_block, ''))
          end
      end.join
    end

    def get_submit_field(tag_submit)
      InputTag.build(tag_submit[:tag_options])
    end
  end
end
