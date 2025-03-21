# frozen_string_literal: true

# "--sidebar-width": SIDEBAR_WIDTH,
# "--sidebar-width-icon": SIDEBAR_WIDTH_ICON,

# TODO: Add keyboard events
# TODO: Open only mobile or normal sidebar
# TODO: state => expanded, collapsed
# TODO: cache

# const MOBILE_BREAKPOINT = 768

module RubyUI
  class Sidebar < Base
    SIDEBAR_WIDTH = "16rem"
    SIDEBAR_WIDTH_ICON = "3rem"

    SIDES = %i[ left right ].freeze
    VARIANTS = %i[ sidebar floating inset ].freeze
    COLLAPSIBLES = %i[ offcanvas icon none ].freeze


    def initialize(side: :left, variant: :sidebar, collapsible: :offcanvas, mobile: false, **attrs)
      raise ArgumentError, "Invalid side: #{side}. Must be one of #{SIDES}." unless SIDES.include?(side)
      raise ArgumentError, "Invalid variant: #{variant}. Must be one of #{VARIANTS}." unless VARIANTS.include?(variant)
      raise ArgumentError, "Invalid collapsible: #{collapsible}. Must be one of #{COLLAPSIBLES}." unless COLLAPSIBLES.include?(collapsible)

      @side = side
      @variant = variant
      @collapsible = collapsible
      @mobile = mobile
      super(**attrs)
    end

    def view_template(&)
      div(**attrs) do
        if @collapsible == :none
          NonCollapsiableSidebar(&)
        else
          MobileSidebar(&)
          CollapsiableSidebar(&)
        end
      end
    end

    private

    def default_attrs
      {
        class: "group/sidebar-wrapper flex min-h-svh w-full has-[[data-variant=inset]]:bg-sidebar",
        style: "--sidebar-width: #{SIDEBAR_WIDTH}; --sidebar-width-icon: #{SIDEBAR_WIDTH_ICON};",
        data: {
          state: "expanded",
          collapsible: @collapsible,
          variant: @variant,
          side: @side
        }
      }
    end
  end
end
