require 'spec_helper'

describe Formdown::Renderer do
  subject { Formdown::Renderer.new(File.read('spec/fixtures/kitchen_sink.fmd')).to_html }
  it "renders text input" do
    expect(subject).to include(%(<input type="text" placeholder="Name" name="Name" size="10"></input>))
  end

  it "renders email input" do
    expect(subject).to include(%(<input type="email" placeholder="Email" name="Email" size="12"></input>))
  end

  it "renders number input" do
    expect(subject).to include(%(<input type="number" placeholder="Sneezes" name="Sneezes" size="2"></input>))
  end

  it "renders submit button" do
    expect(subject).to include(%(<input type="submit" value="Submit response"></input>))
  end

  # TODO - Multiline text area inputs for readability.
  it "renders textarea" do
    expect(subject).to include(%(<textarea placeholder="Description" name="Description" cols="10" rows="3"></textarea>))
  end

  # TODO  - Make text to left, right of this be a lable.
  #       - Support multi-line inputs that act like MD bullets
  it "renders checkbox input"
  it "renders radio buttons"
end