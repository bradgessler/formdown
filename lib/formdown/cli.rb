require 'formdown'
require 'thor'

class Formdown::CLI < Thor
  desc "render", "Render formdown file to html"
  def render
    puts Formdown::Renderer.new($stdin.read).to_html 
  end
end