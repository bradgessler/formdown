require 'spec_helper'

describe Kramdown::Parser::Formdown do
  context "radio button" do
    subject { html 'kitchen_sink.fmd' }
    context "single line" do
      it "renders radio button input" do
        expect(subject).to include(%(<input type="radio"></input>))
      end
      # TODO - Group radio buttons and infer some sort of name that can
      # be mapped back into the document... like `radio-#{radio_instance}`
      # where `seq` monotonically increases per named radio button group.
      #
      # TODO - Does `radio[0]` blow up Sinatra/Rails style parsers? Should it be
      # radio_0?
      it "renders radio button name" do
        pending "parse multiple lines of radio buttons"
        expect(subject).to include('<input type="radio" name="radio[0]" id="radio_0_0"></input>')
      end
      # TODO - Name radio buttons based on the instance of the group AND the sequence of the
      # radio button (e.g. is it the first or last option to choose from?)
      it "renders labels" do
        pending "render labels"
        expect(subject).to include('<label for="radio_0_0">Eat a potato</label>')
      end
      it "is checked" do
        pending "check forms with *, x, or X"
        expect(subject).to include('<input type="radio" name="radio[0]" id="radio_0_1" checked></input>')
      end
    end
  end
end