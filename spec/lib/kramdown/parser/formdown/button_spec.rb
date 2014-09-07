require 'spec_helper'

describe Kramdown::Parser::Formdown do
  context "button" do
    subject { html 'kitchen_sink.fmd' }
    it "renders submit button" do
      expect(subject).to include(%(<input type="submit" value="Submit response"></input>))
    end
  end
end