# frozen_string_literal: true

module UiBibz::Ui::Core::Forms::Files
  # Create a FileField
  #
  # This element is an extend of UiBibz::Ui::Core::Component.
  #
  # ==== Attributes
  #
  # * +content+ - Content of element
  # * +options+ - Options of element
  # * +html_options+ - Html Options of element
  #
  # ==== Options
  #
  # You can add HTML attributes using the +html_options+.
  # You can pass arguments in options attribute:
  # * +state+ - Symbol
  #   (+:active+, +:disabled+)
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::Forms::Texts::FileField.new(content, options = {}, html_options = {}).render
  #
  #   UiBibz::Ui::Core::Forms::Texts::FileField.new(options = {}, html_options = {}) do
  #     content
  #   end.render
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::Forms::Texts::FileField.new('upload', class: 'test')
  #
  #   UiBibz::Ui::Core::Forms::Texts::FileField.new(class: 'test') do
  #     #content
  #   end
  #
  # ==== Helper
  #
  #   ui_file_field(options = {}, html_options = {}) do
  #    # content
  #   end
  #
  class FileField < UiBibz::Ui::Core::Component
    # See UiBibz::Ui::Core::Component.initialize

    # Render html tag
    def pre_render
      content_tag :div, html_options do
        concat file_field_tag content, class: 'form-file-input', multiple: options[:multiple], disabled: disabled?
        concat label_text_and_button
      end
    end

    private

    def label_text_and_button
      label_tag label_name, class: 'form-file-label' do
        concat content_tag(:span, format_value(options[:input_text] || options[:value]), class: 'form-file-text')
        concat content_tag(:span, options[:button_text] || 'Browse', class: 'form-file-button')
      end
    end

    def format_value(value)
      if value.is_a? ActiveStorage::Attached::One
        return '' unless value.attached?

        return value.attachment.blob.filename
      end

      value.to_s
    end

    def label_name
      html_options[:id] || content
    end

    def component_html_classes
      super << 'form-file'
    end
  end
end
