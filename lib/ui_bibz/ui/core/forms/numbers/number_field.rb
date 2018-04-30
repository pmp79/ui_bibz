require 'ui_bibz/ui/extensions/core/forms/surround_extension'
module UiBibz::Ui::Core::Forms::Numbers

  # Create a NumberField
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
  # * +prepend+ - String, Html
  # * +append+ - String, Html
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::Forms::Numbers::NumberField.new(content, options = {}, html_options = {}).render
  #
  #   UiBibz::Ui::Core::Forms::Numbers::NumberField.new(options = {}, html_options = {}) do
  #     content
  #   end.render
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::Forms::Numbers::NumberField.new('search', prepend: 'Prepend content', append: 'Append content', class: 'test')
  #
  #   UiBibz::Ui::Core::Forms::Numbers::NumberField.new(prepend: glyph('pencil'), append: glyph('camera-retro')) do
  #     #content
  #   end
  #
  # ==== Helper
  #
  #   ui_number_field(options = {}, html_options = {}) do
  #    # content
  #   end
  #
  class NumberField < UiBibz::Ui::Core::Forms::Texts::TextField

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
    end

    # Render html tag
    def pre_render
      surround_field number_field_input_tag
    end

    private

    # Simple_form or not
    def number_field_input_tag
      number_field_tag content, options[:value] || html_options[:value], html_options
    end

  end
end