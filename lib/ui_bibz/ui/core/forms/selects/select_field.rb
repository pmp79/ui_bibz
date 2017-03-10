module UiBibz::Ui::Core::Forms::Selects

  # Create a SelectField
  #
  # This element is an extend of UiBibz::Ui::Core::Component.
  # source : http://silviomoreto.github.io/bootstrap-select/examples/
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
  #   (+:primary+, +:secondary+, +:info+, +:warning+, +:danger+, +:link+)
  # * +option_tags+ - Array, Object [required]
  # * +searchable+ - Boolean
  # * +max_options+ - Integer
  # * +selected_text_format+ - String
  # * +menu_size+ - Integer
  # * +header+ - String
  # * +actions_box+ - Boolean
  # * +show_tick+ - Boolean
  # * +show_menu_arrow+ - Boolean
  # * +dropup+ - Boolean
  # * +connect+ - Hash
  #   * +event+ - String
  #   * +mode+ - String
  #   * +target+ - Hash
  #     * +selector+ - String
  #     * +data+ - Array
  #     * +url+ - String
  # * +refresh+ - Hash
  #   * +event+ - String
  #   * +mode+ - String
  #   * +target+ - Hash
  #     * +selector+ - String
  #     * +data+ - Array
  #     * +url+ - String
  #
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::Forms::Selects::SelectField.new(content, options = {}, html_options = {}).render
  #
  #   UiBibz::Ui::Core::Forms::Selects::SelectField.new(options = {}, html_options = {}) do
  #     content
  #   end.render
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::Forms::Selects::SelectField.new('fruits', { option_tags: list_of_fruits, searchable: true }, { class: 'test' })
  #
  #   UiBibz::Ui::Core::Forms::Selects::SelectField.new({ option_tags: list_of_fruits, actions_box: true }, { class: 'test' }) do
  #     'fruits'
  #   end
  #
  # ==== Helper
  #
  #   dropdown_select_field(content, options = {}, html_options = {})
  #
  class SelectField < UiBibz::Ui::Core::ConnectedComponent

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
    end

    # Render html tag
    def render
      if options[:refresh]
        refresh_render
      else
        select_tag content, options[:option_tags], html_options
      end
    end

    private

    def component_html_options
      opts = {}
      opts = opts.merge({ multiple: true })            if options[:multiple]
      opts = opts.merge({ disabled: true })            if options[:state] == :disabled
      opts = opts.merge({ include_blank: true})        if options[:include_blank]
      opts = opts.merge({ prompt: options[:prompt] })  unless options[:prompt].blank?
      opts
    end

    def component_html_classes
      ['select-field', 'form-control']
    end

  end
end