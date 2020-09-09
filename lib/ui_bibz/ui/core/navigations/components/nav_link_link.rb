# frozen_string_literal: true

module UiBibz::Ui::Core::Navigations
  # Create a NavLinkLink
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
  # * +state+ - status of element with symbol value:
  #   (+:active+)
  #
  class NavLinkLink < UiBibz::Ui::Core::Component
    # UiBibz::Ui::Core::Component.initialize

    # Render html tag
    def pre_render
      link_to options[:url], html_options do
        concat glyph_and_content_html
        concat tag_html if options[:tag]
      end
    end

    private

    def component_html_classes
      'nav-link'
    end

    def component_html_options
      options[:nav_type] == 'nav-tabs' ? { 'data-toggle' => 'tab', role: 'tab' } : {}
    end
  end
end
