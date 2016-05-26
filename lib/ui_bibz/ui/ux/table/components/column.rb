module UiBibz::Ui::Ux
  class Column < UiBibz::Ui::Core::Component

    attr_accessor :hidden, :link, :state, :name, :class, :as, :data_index, :date_format, :sort, :format, :date_format, :count, :custom_sort, :parent, :id

    def initialize content = nil, options = nil, html_options = nil, &block
      super
      @data_index  = @content
      @id          = @options[:column_id] || @data_index
      @name        = @options[:name]
      @link        = @options[:link] # for show or edit action
      @order       = @options[:order]
      @date_format = @options[:date_format]
      @sort        = @options[:sort]
      @custom_sort = @options[:custom_sort]
      @parent      = @options[:parent]
      @count       = @options[:count]
      @as          = @options[:as]
      @format      = @options[:format]
      @class       = @options[:class]
      @hidden      = @options[:hidden]
      @state       = @options[:state]
    end

    def linkable?
      !@link.nil?
    end

    def order
      @order || 0
    end

    def hidden?
      @hidden == true
    end

  end
end
