require 'sinatra/base'
require 'formdown/tilt'

module Sinatra
  module Formdown
    module Helpers
      def formdown(template, options = {}, locals = {}, &block)
        render(:formdown, template, options, locals, &block)
      end
    end

    def self.registered(app)
      app.helpers Formdown::Helpers
    end
  end
  
  register Formdown
end