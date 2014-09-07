require 'spec_helper'

describe Kramdown::Parser::Formdown do
  context "text area" do
    subject { html 'kitchen_sink.fmd' }
    # TODO - Multiline text area inputs for readability.
    it "renders textarea" do
      expect(subject).to include(%(<textarea placeholder="Description" name="Description" cols="10" rows="3"></textarea>))
    end
  end
end