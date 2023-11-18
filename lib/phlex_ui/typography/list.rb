# frozen_string_literal: true

module PhlexUI
    class Typography::List < Base
        def initialize(items: [], numbered: false, **attrs)
            @items = items
            @numbered = numbered
            super(**attrs)
        end

        def template(&)
            if @items.empty?
                list(**attrs, &)
            else
                list(**attrs) do
                    @items.each do |item|
                        render PhlexUI::Typography::ListItem.new { item }
                    end
                end
            end
        end

        private

        def list(**attrs, &)
            if numbered?
                ol(**attrs, &)
            else
                ul(**attrs, &)
            end
        end

        def numbered? = @numbered

        def not_numbered? = !numbered?

        def default_attrs
            {
                class: tokens(
                    "my-6 ml-6 [&>li]:mt-2 indent-2",
                    numbered?: "list-decimal marker:font-medium",
                    not_numbered?: "list-disc"
                )
            }
        end
    end
end