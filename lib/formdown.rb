require "formdown/version"

# Formdown extends the Markdown language with practical HTML form builder syntax.
#
# TODO
# - name: parameters should be applied at a different layer, NOT within this file. This will
#   make sure that we don't clobber the users form submissions.
# - DRY up the methods below into more of a macro language. The constants, extractions, etc.
#   are a common pattern.

require 'kramdown'
require 'kramdown/parser/kramdown'
require 'kramdown/document'

module Formdown
  class Parser < Kramdown::Parser::Kramdown
    def initialize(source, options)
      super
      @span_parsers.unshift :text_fields, :text_areas, :checkboxes, :buttons, :radio_buttons
    end

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
    define_parser(:text_fields, TEXT_FIELD_START, '_{')


    TEXT_AREA_START = /(_+)(\/+)\((.+?)\)/

    def parse_text_areas
      @src.pos += @src.matched_size
      col, rows, placeholder = TEXT_AREA_START.match(@src.matched).captures
      @tree.children << Element.new(:html_element, :textarea, placeholder: placeholder, name: placeholder, cols: col.size, rows: rows.size)
    end
    define_parser(:text_areas, TEXT_AREA_START, '_/')


    CHECKBOX_FIELD_START = /\[([\sxX])?\]/

    def parse_checkboxes
      @src.pos += @src.matched_size
      @tree.children << Element.new(:html_element, :input, type: :checkbox)
    end
    define_parser(:checkboxes, CHECKBOX_FIELD_START, '\[')

    RADIO_BUTTON_FIELD_START = /\(([\sxX])?\)/

    def parse_radio_buttons
      @src.pos += @src.matched_size
      @tree.children << Element.new(:html_element, :input, type: :radio)
    end
    define_parser(:radio_buttons, RADIO_BUTTON_FIELD_START, '\(')

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
    define_parser(:buttons, BUTTON_START, '\[')
  end
end

# Work around to get this build passing for Ruby 1.9 since the kramdown Parser.const_get()
# TODO - Patch kramdown to work with nested namespaces in Ruby 1.9
FormdownParser = Formdown::Parser

module Formdown
  class Renderer
    def initialize(content)
      @document = ::Kramdown::Document.new(content, input: 'FormdownParser')
    end

    def to_html
      @document.to_html
    end
  end
end