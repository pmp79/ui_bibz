module CustomInputs
  class DatePickerInput < SimpleForm::Inputs::StringInput
    include UiBibz::Ui::Core

    def input(wrapper_options)
      UiBibz::Ui::Core::DatePickerField.new(attribute_name, input_options, input_html_options).render
    end

  end
end
