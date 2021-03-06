# frozen_string_literal: true

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
  # * +label+ - [String/Boolean]
  # * +boolean+ - Boolean Add an hidden field for rails
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

    # Render html tag
    def pre_render
      checkbox_field_html_tag
    end

    private

    def checkbox_field_html_tag
      content_tag(:div, html_options.except(:id, 'data-action')) do
        concat hidden_field_tag content, '0', id: "#{content}-hidden" if options[:boolean]
        concat check_box_tag content, options[:value] || '1', options[:checked] || html_options[:checked], checkbox_html_options
        concat label_tag(label_name, label_content, class: 'form-check-label') if options[:label] != false
      end
    end

    def checkbox_html_options
      {
        disabled: disabled?,
        indeterminate: options[:indeterminate],
        "data-action": options[:action],
        class: UiBibz::Utils::Screwdriver.join_classes('form-check-input', input_status)
      }.tap do |html|
        html[:id] = html_options[:id] if html_options[:id]
      end
    end

    def label_name
      html_options[:id] || content
    end

    def label_content
      case options[:label]
      when nil
        content
      when false
        ' '
      else
        options[:label]
      end
    end

    def component_html_classes
      super << component_wrapper_html_classes
    end

    def input_status
      "form-check-input-#{options[:status]}" if options[:status]
    end

    def status; end

    def inline
      'form-check-inline' if options[:inline]
    end

    def component_wrapper_html_classes
      ['form-check', inline]
    end
  end
end
