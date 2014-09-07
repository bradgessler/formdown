require 'spec_helper'

describe Kramdown::Parser::Formdown do
  context "text field" do
    subject { html 'kitchen_sink.fmd' }
    it "renders text input" do
      expect(subject).to include(%(<input type="text" placeholder="Name" name="Name" size="10"></input>))
    end

    it "renders email input" do
      expect(subject).to include(%(<input type="email" placeholder="Email" name="Email" size="12"></input>))
    end

    it "renders number input" do
      expect(subject).to include(%(<input type="number" placeholder="Sneezes" name="Sneezes" size="2"></input>))
    end
  end
end
