module UiBibz::Ui::Core::Cards

  # Create a card header
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
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::Cards::CardHeader.new(content, options = nil, html_options = nil)
  #
  #   UiBibz::Ui::Core::Cards::CarHeader.new(options = nil, html_options = nil) do
  #     content
  #   end
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::Cards::CardHeader.new.render
  #
  #   UiBibz::Ui::Core::Cards::CardHeader.new do
  #     'Exemple'
  #   end.render
  #
  class CardHeader < UiBibz::Ui::Core::Component

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
    end

    # Render html tag
    def render
      content_tag :div, glyph_and_content_html, html_options
    end

  private

    def component_html_classes
      "card-header"
    end

  end
end