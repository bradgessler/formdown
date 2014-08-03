require 'kramdown'
require 'kramdown/parser/formdown'
require 'kramdown/document'

module Formdown
  class Renderer
    def initialize(content)
      @document = ::Kramdown::Document.new(content, input: 'Formdown')
    end

    def to_html
      @document.to_html
    end
  end
end