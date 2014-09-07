module Kramdown
  module Parser
    class Formdown < Kramdown::Parser::Kramdown
      RADIO_BUTTON_FIELD_START = /\(([\sxX])?\)/

      def parse_radio_buttons
        @src.pos += @src.matched_size
        @tree.children << Element.new(:html_element, :input, type: :radio)
      end
      define_parser(:radio_buttons, RADIO_BUTTON_FIELD_START)
    end
  end
end