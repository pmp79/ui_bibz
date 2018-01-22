require "ui_bibz/ui/ux/tables/components/store"
require "ui_bibz/ui/ux/tables/components/columns"
require "ui_bibz/ui/ux/tables/components/column"
require "ui_bibz/ui/ux/tables/components/actions"
require "ui_bibz/ui/ux/tables/components/thead"
require "ui_bibz/ui/ux/tables/components/as"
require "ui_bibz/ui/ux/tables/extensions/paginable"
require "ui_bibz/ui/ux/tables/extensions/paginable"
require "ui_bibz/ui/ux/tables/extensions/searchable"
require "ui_bibz/ui/ux/tables/extensions/sortable"
require "ui_bibz/ui/ux/tables/extensions/actionable"
module UiBibz::Ui::Ux::Tables

  # Create a Table
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
  # * +store+ - Store generate by '+table_search_pagination+' method
  # * +url+ - String
  # * +tap+ - Boolean
  # * +actionable+ - Boolean
  # * +sortable+ - Boolean
  # * +searchable+ - Boolean
  # * +default_actions+ - Boolean
  # * +status+
  #   (+:inverse+, +:default+, +:success+, +:primary+, +:secondary+, +:info+,
  #   +:danger+, +:warning+)
  # * +thead+ - Hash
  #   (+status+)
  #     (+:inverse+, +:default+)
  # * +bordered+ - Boolean
  # * +hoverable+ - Boolean
  # * +size+
  #   (+:sm+)
  # * +responsive+ - Boolean
  # * +reflow+ - Boolean
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Ux::Tables::Table.new(store: @store)
  #
  #   UiBibz::Ui::Ux::Tables::Table.new(store: @store, tap: true) do |t|
  #     t.columns do |c|
  #       c.column :id, name: '#'
  #     end
  #     t.actions do |a|
  #       a.link '', url: url, glyph: ''
  #     end
  #   end
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Ux::Tables::Table.new(store: @users).render
  #
  #   UiBibz::Ui::Ux::Tables::Table.new(store: @users).tap do |t|
  #     t.columns do |c|
  #       c.column :id, { name: '#' }
  #       c.column :name_fr', { link: edit_user_path(:id), order: 2 }
  #       c.column :name_en'
  #       c.column :state_id, { name: 'state', format: lambda{ |records, record| "Test #{ record.id}"} }
  #     end
  #     t.actions do |a|
  #       a.link 'state', url: users_path(:id), glyph: 'eye'
  #       a.divider
  #       a.link 'momo', url: users_path(:id), glyph: 'home'
  #     end
  #   end.render
  #
  # ==== Helper
  #
  #   table(options = {}, html_options = {})
  #
  #   table(options = { tap: true }, html_options = {}) do |t|
  #     t.columns do |cls|
  #       cls.column(name, options = {}, html_options = {})
  #       cls.column(options = {}, html_options = {}) do
  #         name
  #       end
  #     end
  #     t.actions do |acs|
  #       acs.link(content, options = {}, html_options = {})
  #       acs.link(options = {}, html_options = {}) do
  #         content
  #       end
  #     end
  #   end
  class Table < UiBibz::Ui::Core::Component

    attr_accessor :columns

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
      @columns = Columns.new
      @actions = Actions.new store
    end

    # Add table columns items
    def columns &block
      @columns.tap(&block)
    end

    # Add table actions items
    def actions &block
      @actions.tap(&block)
    end

    # for test
    def actions_list
      @actions
    end

    # Render html tag
    def pre_render
      table_html
    end

    # Store must be generated by *table_search_pagination* method
    def store
      @store ||= if @options[:store].nil?
        raise 'Store is nil!'
      elsif @options[:store].try(:records).nil?
        raise 'Store can be created only with "table_search_pagination" method!'
      else
        Store.new @options.delete :store
      end
    end

  protected

    def sort
      @sort ||= Sortable.new store, @options
    end

    def action
      @action ||= Actionable.new store, @options, @actions
    end

    def cols
      @columns.list.empty? ? store.columns.list : @columns.list
    end

    def type
      "table-#{ @options[:type] }" unless @options[:type].nil?
    end

    def table_html
      content_tag(:table, html_options) do

        ths = cols.collect do |col|
          content_tag(:th, sort.header(col), class: col.class) unless col.hidden?
        end

        ths = action.header ths
        concat Thead.new(content_tag(:tr, ths.join.html_safe), @options[:thead]).render

        trs = store.records.collect do |record|
          tds = cols.collect do |col|
            content_tag(:td, td_content(record, col), class: col.class) unless col.hidden?
          end

          tds = action.body record, tds
          content_tag(:tr, tds.join.html_safe)
        end

        concat content_tag :tbody, trs.join.html_safe
      end
    end

    # Maybe create a class for td_content
    def td_content record, col
      content = col.count ? record.send(col.data_index).count : record.send(col.data_index)
      unless content.nil?
        content = content.strftime(col.date_format)                    unless col.date_format.nil?
        content = link_to content, action.inject_url(col.link, record) unless col.link.nil?
        content = col.format.call(@store.records, record)              unless col.format.nil?
      end
      content = As.new(col, record, content, @options).render unless col.as.nil?
      content
    end

  private

    def component_html_classes
      ["table", striped, bordered, hoverable, size, responsive, reflow]
    end

    def status
      "table-#{ @options[:status] }" unless @options[:status].nil?
    end

    def striped
      "table-striped" unless @options[:striped].nil?
    end

    def bordered
      "table-bordered" unless @options[:bordered].nil?
    end

    def hoverable
      "table-hoverable" unless @options[:hoverable].nil?
    end

    def size
      "table-#{ @options[:size] }" unless @options[:size].nil?
    end

    def responsive
      "table-responsive" unless @options[:responsive].nil?
    end

    def reflow
      "table-reflow" unless @options[:reflow].nil?
    end

  end
end
