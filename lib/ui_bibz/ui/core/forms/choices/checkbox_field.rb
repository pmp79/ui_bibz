module UiBibz::Ui::Core::Forms::Choices

  # Create a checkbox
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
  # * +inline+ - Boolean
  # * +checked+ - Boolean
  # * +action+ - String Stimulus Option
  # * +label+ - String
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::Forms::CheckboxField.new(content, options = nil, html_options = nil)
  #
  #   UiBibz::Ui::Core::Forms::CheckboxField.new(options = nil, html_options = nil) do
  #     content
  #   end
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::Forms::CheckboxField.new(content, { status: :success, type: :circle },{ class: 'test' }).render
  #
  #   UiBibz::Ui::Core::Forms::CheckboxField.new({ status: :primary }, { class: 'test' }) do
  #     content
  #   end.render
  #
  # ==== Helper
  #
  #   ui_checkbox_field(content, options = {}, html_options = {})
  #
  #   ui_checkbox_field(options = {}, html_options = {}) do
  #     content
  #   end
  #
  class CheckboxField < UiBibz::Ui::Core::Component

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
    end

    # Render html tag
    def pre_render
      checkbox_field_html_tag
    end

  private

    def checkbox_field_html_tag
      options[:action] = html_options[:data].delete(:action)
      content_tag(:div, html_options.except(:id, "data-action")) do
        concat hidden_field_tag content, '0', id: "#{ content }-hidden"
        concat check_box_tag content, options[:value] || '1', options[:checked] || html_options[:checked], checkbox_html_options
        concat label_tag label_name, label_content, class: 'custom-control-label'
      end
    end

    def checkbox_html_options
      {
        disabled: is_disabled?,
        indeterminate: options[:indeterminate],
        "data-action": options[:action],
        class: 'custom-control-input'
      }
    end

    def label_name
      html_options[:id] || content
    end

    def label_content
      case options[:label]
      when nil
        content
      when false
        " "
      else
        options[:label]
      end
    end

    def component_html_classes
      super << ["custom-control", "custom-checkbox", inline]
    end

    def inline
      "custom-control-inline" if options[:inline]
    end

  end
end
