require 'kramdown'
require 'kramdown/parser/kramdown'

# Formdown extends the Markdown language with practical HTML form builder syntax.
#
# TODO
# - name: Form values should be applied at a different layer, NOT within this file. This will
#   make sure that we don't clobber the users form submissions.
# - DRY up the methods below into more of a macro language. The constants, extractions, etc.
#   are a common pattern.

module Kramdown
  module Parser
    class Formdown < Kramdown::Parser::Kramdown
      def initialize(source, options)
        super
        @span_parsers.unshift :text_fields, :text_areas, :buttons, :options_field
      end

      require "kramdown/parser/formdown/text_field"
      require "kramdown/parser/formdown/text_area"
      require "kramdown/parser/formdown/button"
      require "kramdown/parser/formdown/options_field"
    end
  end
end