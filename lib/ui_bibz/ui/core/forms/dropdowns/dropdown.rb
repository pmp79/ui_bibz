require 'ui_bibz/ui/core/forms/dropdowns/components/dropdown_header'
require 'ui_bibz/ui/core/forms/dropdowns/components/dropdown_divider'
require 'ui_bibz/ui/core/forms/dropdowns/components/dropdown_link'
module UiBibz::Ui::Core::Forms::Dropdowns

  # Create a dropdown
  #
  # This element is an extend of UiBibz::Ui::Core::Component.
  # You can use tap method to add list items.
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
  # * +status+ - status of élement with symbol value:
  #   (+:primary+, +:secondary+, +:info+, +:warning+, +:danger+)
  # * +size+
  #   (+:xs+, +:sm+, +:lg+)
  # * +glyph+ - Add glyph with name or hash options
  #   * +name+ - String
  #   * +size+ - Integer
  #   * +type+ - Symbol
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::Forms::Dropdowns::Dropdown.new(options = nil, html_options = nil).tap do |d|
  #     ...
  #     d.header content = nil, options = nil, html_options = nil, &block
  #     d.divider
  #     d.link content = nil, options = nil, html_options = nil, &block
  #     ...
  #   end
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::Forms::Dropdowns::Dropdown.new(name, status: :success).tap do |d|
  #     d.link 'test', { url: '#' }
  #     d.divider
  #     d.header 'Header 1'
  #     d.link 'test2', { url: '#' }
  #   end.render
  #
  # ==== Helper
  #
  #   dropdown(name, options = { tap: true }, html_options = {}) do |d|
  #     d.link(content, options = {}, html_options = {})
  #     d.link(options = {}, html_options = {}) do
  #       content
  #     end
  #     d.divider
  #     d.header(content, options = {}, html_options = {})
  #     d.header(options = {}, html_options = {}) do
  #       content
  #     end
  #   end
  #
  class Dropdown < UiBibz::Ui::Core::Component

    def initialize content, options = nil, html_options  = nil, &block
      super
      @items = []
      @status = @options.delete(:status)
    end

    # Render html tag
    def render
      content_tag :div, html_options do
        concat button_html
        concat ul_html
      end
    end

    # Add dropdown header
    # See UiBibz::Ui::Core::Forms::Dropdowns::Components::DropdownHeader
    def header content = nil, options = nil, html_options = nil, &block
      @items << UiBibz::Ui::Core::Forms::Dropdowns::Components::DropdownHeader.new(content, options, html_options, &block).render
    end

    # Add dropdown Separator
    # See UiBibz::Ui::Core::Forms::Dropdowns::Components::DropdownDivider
    def divider
      @items << UiBibz::Ui::Core::Forms::Dropdowns::Components::DropdownDivider.new.render
    end

    # Add dropdown link in list
    # See UiBibz::Ui::Core::Forms::Dropdowns::Components::DropdownLink
    def link content = nil, options = nil, html_options = nil, &block
      @items << UiBibz::Ui::Core::Forms::Dropdowns::Components::DropdownLink.new(content, options, html_options, &block).render
    end

    # Add html component
    def html content
      @items << content
    end

    def id
      @id ||= html_options[:id] || generate_id("dropdown")
    end

  protected

    def component_html_classes
      [type, open, inline]
    end

    def button_content
      [glyph_with_space, @content, ' ', caret].compact.join.html_safe
    end

    def button_html
      if options[:tag] == :a
        content_tag dropdown_tag, button_content, class: join_classes("btn", button_status, state, size, "dropdown-toggle"), href: '#', role: 'button', "data-toggle" => 'dropdown', "aria-haspopup" => true, "aria-expanded" => false, "id" => id
      else
        content_tag dropdown_tag, button_content, class: join_classes("btn", button_status, state, size, "dropdown-toggle"), type: 'button', "data-toggle" => 'dropdown', "aria-haspopup" => true, "aria-expanded" => false, "id" => id
      end
    end

    def ul_html
      content_tag :div, @items.join.html_safe, class: join_classes("dropdown-menu", position, open), "arial-labelledby" => id
    end

    def caret
      content_tag :span, '', class: 'caret'
    end

    def dropdown_tag
      options[:tag] || :button
    end

    def position
      "dropdown-menu-#{ @options[:position] }" unless @options[:position].nil?
    end

    def type
      @options[:type] || 'dropdown'
    end

    def open
      "show" if @options[:open]
    end

    def inline
      "btn-group" if @options[:inline]
    end

    def outline
      "outline" if @options[:outline]
    end

    def button_status
      ["btn", outline, @status || :secondary].compact.join('-')
    end

    # :lg, :sm or :xs
    def size
      "btn-#{ @options[:size] }" if @options[:size]
    end

  end
end