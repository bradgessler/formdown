module Kramdown
  module Parser
    class Formdown < Kramdown::Parser::Kramdown
      # Radio buttons may be "checked" with (*), (x).
      RADIO_BUTTON_CHECKED = /[x*]/i

      # Radio buttons begin with a () and may optionally be checked or have a space.
      RADIO_BUTTON_FIELD_START = /\((?:#{RADIO_BUTTON_CHECKED}|\s)?\)/

      # A radio button label is any text after a radio button up to the next radio button or a new line.
      RADIO_BUTTON_FIELD_LABEL = /(.*?)(?=#{RADIO_BUTTON_FIELD_START}|\n|\Z)/

      def parse_radio_buttons
        # Get a DOM id for labels and such.
        dom_id = next_dom_id

        # Find the start of the radio button.
        @src.scan(RADIO_BUTTON_FIELD_START)
        @tree.children << Element.new(:html_element, :input, type: :radio, id: dom_id)

        # Read the radio button label.
        if label = @src.scan(RADIO_BUTTON_FIELD_LABEL)
          @tree.children << Element.new(:html_element, :label, for: dom_id)
          @tree.children.last.children << Element.new(:text, label.strip)
        end
      end
      define_parser(:radio_buttons, RADIO_BUTTON_FIELD_START)

      # Generates IDs for labels
      def next_dom_id
        @id ||= 0
        [:radio, @id+=1].join("_")
      end
    end
  end
end
