module Kramdown
  module Parser
    class Formdown < Kramdown::Parser::Kramdown
      CHECKBOX_FIELD_START = /\[([\sxX])?\]/

      def parse_checkboxes
        @src.pos += @src.matched_size
        @tree.children << Element.new(:html_element, :input, type: :checkbox)
      end
      define_parser(:checkboxes, CHECKBOX_FIELD_START)
    end
  end
end