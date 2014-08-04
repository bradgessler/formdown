require 'formdown'
require 'tilt/template'

module Tilt
  class FormdownTemplate < Template
    # DUMB_QUOTES = [39, 39, 34, 34]

    def self.engine_initialized?
      defined? ::Formdown
    end

    def initialize_engine
      require_template_library 'formdown'
    end

    def prepare
      # options[:smart_quotes] = DUMB_QUOTES unless options[:smartypants]
      # @engine = Formdown::Document.new(data, options)
      @engine = Formdown::Renderer.new(data)
      @output = nil
    end

    def evaluate(scope, locals, &block)
      @output ||= @engine.to_html
    end

    def allows_script?
      false
    end
  end
end

# TODO - Support lazy registration when Middleman supports Tilt 2.x.
# Tilt.register_lazy :FormdownTemplate, 'tilt/formdown', 'formdown', 'fmd'
Tilt.register Tilt::FormdownTemplate, *Formdown::FILE_EXTENSIONS
