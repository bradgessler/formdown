module Kramdown
  module Parser
    class Formdown < Kramdown::Parser::Kramdown
      # Radio buttons may be "checked" with (*), (x).
      RADIO_BUTTON_CHECKED = /[x*]/i

      # Radio buttons begin with a () and may optionally be checked or have a space.
      RADIO_BUTTON_FIELD_START = /\((?:#{RADIO_BUTTON_CHECKED}|\s)?\)/

      # A radio button label is any text after a radio button up to the next radio button or a new line.
      RADIO_BUTTON_FIELD_LABEL = /(.*?)(?=#{RADIO_BUTTON_FIELD_START}|\n|\Z)/

      # Scan for the next radio button in the collection
      NEXT_RADIO_BUTTON_FIELD = /\n?#{RADIO_BUTTON_FIELD_START}/

      # Name stuff in HTML
      HTML_NAME_SEGMENT_DELIMITER = "_".freeze

      def parse_radio_buttons
        # Setup a fieldset and seed a radio_id at 0.
        field_id, radio_id = next_field_id, 0

        # Now lets setup the fieldset.
        fieldset = Element.new(:html_element, :fieldset, name: html_name(:fieldset, field_id))

        # Parse the list of the radio buttons.
        # TODO - How do I tell the scanner to consider looking over a newline???
        while @src.scan(NEXT_RADIO_BUTTON_FIELD)
          parse_radio_button_and_label fieldset, field_id, radio_id
          radio_id += 1
        end

        # Throw the fieldset into the AST.
        @tree.children << fieldset
      end
      define_parser(:radio_buttons, RADIO_BUTTON_FIELD_START)

      protected

      def parse_radio_button_and_label(fieldset, field_id, radio_id)
        # Get a DOM id for labels and such.
        radio_dom_id = html_name(:radio, field_id, radio_id)
        radio_name = html_name(:radio, field_id)

        fieldset.children << Element.new(:html_element, :input, type: :radio, id: radio_dom_id, name: radio_name)

        # Read the radio button label.
        if label = @src.scan(RADIO_BUTTON_FIELD_LABEL)
          fieldset.children << Element.new(:html_element, :label, for: radio_dom_id)
          fieldset.children.last.children << Element.new(:text, label.strip)
        end
      end

      def html_name(*segments)
        segments.join(HTML_NAME_SEGMENT_DELIMITER)
      end

      def next_field_id
        @field_id ? (@field_id += 1) : (@field_id = 0)
      end
    end
  end
end
