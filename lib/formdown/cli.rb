require 'formdown'
require 'thor'

class Formdown::CLI < Thor
  desc "render", "Render formdown file to html"
  def render
    if $stdin.tty?
      error "Pipe Formdown into this command. Example: `$ echo 'Email: ____@(Email)' | formdown render`"
    else
      puts Formdown::Renderer.new($stdin.read).to_html 
    end
  end

  desc "version", "Print the version of formdown"
  def version
    puts Formdown::VERSION
  end
end