module CustomInputs
  class MarkdownEditorInput < SimpleForm::Inputs::StringInput
    include UiBibz::Ui::Core

    def input(wrapper_options)
      options = @options.merge({ builder: @builder })
      UiBibz::Ui::Core::MarkdownEditorField.new(attribute_name, options, input_html_options).render
    end

  end
end