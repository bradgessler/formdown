require 'formdown'

# TODO - Implement rails auto-detection code so that we dont have to
# `gem 'formdown', require: 'formdown/rails'` from the rails app Gemfile.
module ActionView
  module Template::Handlers
    class Formdown
      class_attribute :default_format
      self.default_format = Mime::HTML

      def call(template)
        ::Formdown::Renderer.new(template.source).to_html.inspect
      end
    end
  end
end

# Register in the rails stack.
ActionView::Template.register_template_handler(:fmd, ActionView::Template::Handlers::Formdown.new)