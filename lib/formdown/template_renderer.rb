require 'uri'

module Formdown  
  # Render Formdown within a form tag or HTML page.
  class TemplateRenderer
    # Default form post method.
    FORM_METHOD = "post"

    # Form tag template.
    FORM_TEMPLATE = "<form %{attributes}>%{html}</form>"

    def initialize(content, options = {})
      @document = Formdown::Renderer.new(content)
      @form = options.delete(:form)
    end

    # Render HTML <form/> tag with attributes and form elements.
    def to_html
      html = @document.to_html
      if @form
        html = FORM_TEMPLATE % { attributes: attributes, html: html }
      end
      html
    end

  private
    # Generate the attrbutes for the form tag.
    def attributes
      @form.map{ |k,v| "#{k}=\"#{URI.escape(v)}\"" }.join(" ")
    end
  end
end
