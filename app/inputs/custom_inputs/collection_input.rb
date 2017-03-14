module CustomInputs
  class CollectionInput < SimpleForm::Inputs::CollectionInput
    include UiBibz::Ui::Core::Forms::Selects
    include ActionView::Helpers::FormOptionsHelper

    def input_html_options
      opts = super
      opts = opts.merge({ prompt: options[:prompt] })               unless options[:prompt].blank?
      opts = opts.merge({ disabled: options[:disabled] })           unless options[:disabled].blank?
      opts = opts.merge({ include_blank: options[:include_blank] }) unless options[:include_blank].blank?
      opts = opts.merge({ multiple: options[:multiple] })           unless options[:multiple].blank?
      opts
    end

    def new_options
      label_method, value_method = detect_collection_methods

      if options[:grouped] == true
        options.merge({ option_tags: option_groups_from_collection_for_select(
          grouped_collection,
          group_method, group_label_method,
          value_method, label_method,
          @builder.object.send(attribute_name) #input_options, input_html_options
        )})
      else
        #ap @builder.object.send(attribute_name)
        options.merge({ option_tags: options_from_collection_for_select(
          collection, value_method, label_method, @builder.object.send(attribute_name)#,input_options, input_html_options
        )})
      end
    end

    def grouped_collection
      @grouped_collection ||= begin
        grouped_collection = options.delete(:collection)
        grouped_collection.respond_to?(:call) ? grouped_collection.call : grouped_collection.to_a
      end
    end

    def collection
      # if options[:grouped]
      #   @collection ||= grouped_collection.map { |collection| collection.try(:send, group_method) }.detect(&:present?) || []
      # else
      #   @collection ||= options[:collection]
      # end
      @collection ||= begin
        if options[:grouped]
          grouped_collection.map { |collection| collection.try(:send, group_method) }.detect(&:present?) || []
        else
          collection = options.delete(:collection) || self.class.boolean_collection
          collection.respond_to?(:call) ? collection.call : collection.to_a
        end
      end
    end

    def group_method
      @group_method ||= options.delete(:group_method)
    end

    def group_label_method
      label = options.delete(:group_label_method)

      unless label
        common_method_for = detect_common_display_methods(detect_collection_classes(grouped_collection))
        label = common_method_for[:label]
      end

      label
    end
  end
end
