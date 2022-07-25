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

    context "when a quantity isn't a positive integer" do
      it "raises an argument error" do
        expect { described_class.new(input: "-5 IMG") }.to raise_error(ArgumentError, "-5 is not an integer greater than 0!")
        expect { described_class.new(input: "27.5 IMG") }.to raise_error(ArgumentError, "27.5 is not an integer greater than 0!")
      end
    end

    context "when the format isn't valid" do
      it "raises an argument error" do
        expect { described_class.new(input: "5 ARTICLE") }.to raise_error(ArgumentError, "ARTICLE is not a supported format!")
      end
    end
  end

  context "with a valid input" do
    it 'creates a list of valid posts' do
      expect(described_class.new(input: "5 FLAC").posts.length).to eq(1)
      expect(described_class.new(input: "5 FLAC 3 VID 19 IMG").posts.length).to eq(3)
    end
  end

  describe '#print_cost_breakdown' do
    subject { described_class.new(input: "15 FLAC 30 VID 9 IMG").print_cost_breakdown }

    it "prints a receipt of the cost breakdown for the order" do
      expect { subject }.to output("9 IMG $450\n\t1 X 5 $450\n30 VID $5160\n\t3 X 9 $4590\n\t1 X 3 $570\n15 FLAC $1957.5\n\t1 X 9 $1147.5\n\t1 X 6 $810\n").to_stdout
    end
  end
end
