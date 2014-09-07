module Kramdown
  module Parser
    class Formdown < Kramdown::Parser::Kramdown
      TEXT_AREA_START = /(_+)(\/+)\((.+?)\)/

      def parse_text_areas
        @src.pos += @src.matched_size
        col, rows, placeholder = TEXT_AREA_START.match(@src.matched).captures
        @tree.children << Element.new(:html_element, :textarea, placeholder: placeholder, name: placeholder, cols: col.size, rows: rows.size)
      end
      define_parser(:text_areas, TEXT_AREA_START)
    end
  end
end