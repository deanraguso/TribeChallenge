require_relative "../../src/models/order.rb"

RSpec.describe ::Order, type: :class do
  context "with an invalid input" do
    context "when the input argument structure is invalid" do
      it "raises an argument error" do
        expect { described_class.new }.to raise_error(ArgumentError)
        expect { described_class.new(input: "asdf") }.to raise_error(ArgumentError)
        expect { described_class.new(input: "asdf 12342134 asdf") }.to raise_error(ArgumentError)
      end
    end
  end
end
