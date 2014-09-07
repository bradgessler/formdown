module Kramdown
  module Parser
    class Formdown < Kramdown::Parser::Kramdown
      TEXT_FIELD_START = /(_+)([@\#]?)\((.+?)\)/

      def parse_text_fields
        @src.pos += @src.matched_size
        line, type, placeholder = TEXT_FIELD_START.match(@src.matched).captures
        # Optionally pull out email or number types.
        type = case type
        when '@' then :email
        when '#' then :number
        else :text
        end
        @tree.children << Element.new(:html_element, :input, type: type, placeholder: placeholder, name: placeholder, size: line.size)
      end
      define_parser(:text_fields, TEXT_FIELD_START)
    end
  end
end