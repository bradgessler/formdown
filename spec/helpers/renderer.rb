module Formdown
  module Spec
    module Helpers
      # Render formdown into HTML.
      def html(template)
        fixture(template).to_html
      end

      # Render formdown into HTML.
      def fixture(template)
        Formdown::Renderer.new(File.read(File.join('spec/fixtures/', template)))
      end
    end
  end
end