require 'ui_bibz/ui/core/progress_bar/components/bar'
module UiBibz::Ui::Core

  # Create a progress bar
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
  # * +state+ - State of élement with symbol value:
  #   (+:default+, +:primary+, +:info+, +:warning+, +:danger+)
  # * label - String (default: "percentage%")
  # * tap - Boolean (true: To add several bars)
  # * percentage_min - Integer (default: 0)
  # * percentage_max - Integer (default: 100)
  # * sr_only - Boolean to show label (default: false)
  # * type
  #   (+:striped+, +:animated+)
  #
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::ProgressBar.new(percentage, options = nil, html_options = nil)
  #
  #   UiBibz::Ui::Core::ProgressBar.new(options = nil, html_options = nil) do
  #     percentage
  #   end
  #
  #   UiBibz::Ui::Core::ProgressBar.new(tap: true).tap do |pb|
  #     pb.bar percentage, options = nil, html_options = nil
  #     pb.bar options = nil, html_options = nil do
  #       percentage
  #     end
  #   end
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::ProgressBar.new(50)
  #   # or
  #   UiBibz::Ui::Core::ProgressBar.new(10, { state: :success, sr_only: false, label: 'Loading...' },{ class: 'test' }).render
  #   # or
  #   UiBibz::Ui::Core::ProgressBar.new(tap: true).tap |pb|
  #     pb.bar 10, { state: :success, sr_only: false, label: 'Loading...' },{ class: 'test' }
  #     pb.bar { state: :primary } do
  #       20
  #     end
  #   end.render
  #
  # ==== Helper
  #
  #   progress_bar(integer, options = {}, html_options = {})
  #
  #   progress_bar(options = { tap: true }, html_options = {}) do |pb|
  #     pb.bar(integer, options = {}, html_options = {})
  #     pb.bar(options = {}, html_options = {}) do
  #       integer
  #     end
  #   end
  #
  class ProgressBar < Component

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
      @bars = []
    end

    # Render html tag
    def render
      content_tag :progress, content, class: 'progress'
    end

    # Add progressbar bar items
    # See UiBibz::Ui::Core::Bar
    def bar content = nil, options = nil, html_options = nil, &block
      @bars << Bar.new(content, options, html_options, &block).render
    end

  private

    def content
      @options[:tap] ? @bars.join().html_safe : Bar.new(@content, @options, @html_options).render
    end

  end
end
