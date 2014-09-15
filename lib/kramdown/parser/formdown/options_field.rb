module Kramdown
  module Parser
    class Formdown < Kramdown::Parser::Kramdown
      # Radio buttons may be "checked" with (*), (x).
      OPTIONS_CHECKED = /[x*]/i

      # Radio buttons begin with a () and may optionally be checked or have a space.
      OPTIONS_FIELD_RADIO_INPUT = /\((?:#{OPTIONS_CHECKED}|\s)?\)/

      # Check boxes too
      OPTIONS_FIELD_CHECKBOX_INPUT = /\[(?:#{OPTIONS_CHECKED}|\s)?\]/

      # Are we going to be working with radio buttons or a checklist?
      OPTIONS_FIELD_START = /#{OPTIONS_FIELD_RADIO_INPUT}|#{OPTIONS_FIELD_CHECKBOX_INPUT}/

      # A radio button label is any text after a radio button up to the next radio button or a new line.
      OPTIONS_FIELD_LABEL = /(.*?)(?=#{OPTIONS_FIELD_RADIO_INPUT}|\n|\Z)/

      # Delimiter for name and id HTML attributes.
      HTML_NAME_SEGMENT_DELIMITER = "_".freeze

      # Parse radio button or checkbox input fields.
      def parse_options_field
        # Setup a fieldset and seed a option_id at 0.
        field_id, option_id = next_field_id, 0

        # Figure out if we're working with a radio or checkbox input.
        option_type, options_start_exp = if @src.check(OPTIONS_FIELD_RADIO_INPUT)
          [:radio, OPTIONS_FIELD_RADIO_INPUT]
        else
          [:checkbox, OPTIONS_FIELD_CHECKBOX_INPUT]
        end

        # Now lets setup the fieldset.
        fieldset = Element.new(:html_element, :fieldset, name: html_name(:fieldset, field_id))

        # Parse the list of the radio buttons.
        #
        # TODO - How do I tell the scanner to consider looking over a newline?
        #
        # TODO - Build out a list if the next radio button is a new line; otherwise
        #        stick with an inline rendition.
        while @src.scan(/\n?#{options_start_exp}/)
          parse_options_and_label fieldset, field_id, option_type, option_id
          option_id += 1
        end

        # Throw the fieldset into the AST.
        @tree.children << fieldset
      end
      define_parser(:options_field, OPTIONS_FIELD_START)

      protected

      # Parses the input and label for a radio button.
      def parse_options_and_label(fieldset, field_id, option_type, option_id)
        # Get a DOM id for labels and such.
        option_dom_id = html_name(option_type, field_id, option_id)
        option_name = html_name(option_type, field_id)

        fieldset.children << Element.new(:html_element, :input, type: option_type, id: option_dom_id, name: option_name)

        # Read the radio button label.
        if label = @src.scan(OPTIONS_FIELD_LABEL)
          fieldset.children << Element.new(:html_element, :label, for: option_dom_id)
          fieldset.children.last.children << Element.new(:text, label.strip)
        end
      end

      # Joins name segments using a delimiter for generating name 
      # and id DOM attribute values
      def html_name(*segments)
        segments.join(HTML_NAME_SEGMENT_DELIMITER)
      end

      # Generates a name for each Formdown input field.
      # TODO - Move this into the base class somewhere so
      #        we can keep track of all the Formdown inputs.
      def next_field_id
        @field_id ? (@field_id += 1) : (@field_id = 0)
      end
    end
  end
end
