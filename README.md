[![Build Status](https://travis-ci.org/bradgessler/formdown.svg?branch=master)](https://travis-ci.org/bradgessler/formdown)

# Formdown

Build HTML forms with the simplicity of [Markdown](http://daringfireball.net/projects/markdown/). In other words, markdown like:

```markdown
Hi _________(Name)

How are you doing today? () Good () Ok () Bad

Could I have your email address? __________@(Email)

Write a few lines that describe your mood: ____________///(Mood)

[ Submit your feelings ]
```

Generates the following HTML:

```html
<p>Hi   <input type="text" placeholder="Name" name="Name" size="9"></input>
</p>

<p>How are you doing today?   <input type="radio"></input>
 Good   <input type="radio"></input>
 Ok   <input type="radio"></input>
 Bad</p>

<p>Could I have your email address?   <input type="email" placeholder="Email" name="Email" size="10"></input>
</p>

<p>Write a few lines that describe your mood:   <textarea placeholder="Mood" name="Mood" cols="12" rows="3"></textarea>
</p>

<p>  <input type="submit" value="Submit your feelings"></input>
</p>
```

A more extensive reference of Formdown in action may be found in the [kitchen sink](./spec/fixtures/kitchen_sink.fmd) fmd file. As this gem matures more extensive syntax documentation will be created for version 1.0.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'formdown'
```

or for Rails:

```ruby
gem 'formdown', require: 'formdown/rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install formdown

## Usage

### CLI

The quickest way to render Formdown is via the command line. Just cat your file into the render and you'll get HTML:

```sh
$ cat my_form.fmd | formdown render > my_form.html
```

Now open `my_form.html` and enjoy all of that HTML goodness.

### Ruby

```ruby
text = "What is your email address? _________@(Email)"
formdown = Formdown::Renderer.new(text)
formdown.to_html # => "<p>What is your email address?   <input type=\"email\" placeholder=\"Email\" name=\"Email\" size=\"9\"></input>\n</p>\n"
```

### Rails

In the rails Gemfile, include the formdown gem via:

```ruby
gem "formdown", require: "formdown/rails"
```

Rails will pick up files with the extension `.fmd` and render them as HTML. For example, `app/views/user/my_form.html.fmd` would render the formdown document.

Its recommended to use a layout around the Formdown file to handle the form submission action and surrounding HTML content.

**Note**: There's currently no simple way of mapping Formdown fields to ActiveRecord model attributes.

### Sinatra

In the Gemfile, include the formdown gem via:

```ruby
gem "formdown", require: "sinatra/formdown"
```

Place your Formdown file in the [Sinatra](http://www.sinatrarb.com/) `./views` directory (e.g. `views/my_form.html.fmd`), then add the following route to your Sinatra app:

```ruby
get '/my_form' do
  formdown :my_form
end
```

and the form will render at `/my_form`.

### Middleman

In the Gemfile, include the formdown gem via:

```ruby
gem "formdown", require: "middleman/formdown"
```

Place your Formdown file in the [Middleman](http://middlemanapp.com/) `./source` directory and the form will render (e.g. `source/my_form.html.fmd` will render the form at `/my_form.html`)

## Contributing

1. Fork it ( https://github.com/bradgessler/formdown/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
