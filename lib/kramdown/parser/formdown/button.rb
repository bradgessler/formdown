module Kramdown
  module Parser
    class Formdown < Kramdown::Parser::Kramdown
      BUTTON_START = /\[\s(.+)\s\]([\!])?/

      def parse_buttons
        @src.pos += @src.matched_size
        value, type = BUTTON_START.match(@src.matched).captures
        type = case type
        when '!' then :submit
        # else :button
        else :submit # TODO - Should we even support other types of buttons? Probably not... just make it a submit.
        end
        @tree.children << Element.new(:html_element, :input, type: type, value: value)
      end
      define_parser(:buttons, BUTTON_START)
    end
  end
end