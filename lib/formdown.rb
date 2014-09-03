require 'formdown/version'

module Formdown
  # File extensions for various template handlers.
  FILE_EXTENSIONS = %w[formdown fmd].freeze

  autoload :Renderer,         'formdown/renderer'
  autoload :TemplateRenderer, 'formdown/template_renderer'
end