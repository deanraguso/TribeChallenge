require_relative "../../src/models/post.rb"

RSpec.describe ::Post, type: :class do
  it "has all formats available for reading" do
    expect(described_class::FORMATS.length).to eq(3)
  end

  it "has all bundles available for reading" do
    expect(described_class::FORMAT_BUNDLES.length).to eq(3)
  end

  context "with invalid params" do
    context "when the format is invalid" do
      it "fails to be created" do
        expect { described_class.new(format: "ARTICLE", quantity: 2) }.to raise_error(ArgumentError, "ARTICLE is not a supported format!")
      end
    end

    context "when quantity is invalid" do
      it "fails to be created" do
        expect { described_class.new(format: "FLAC", quantity: 27.5) }.to raise_error(ArgumentError, "27.5 is not an integer greater than 0!")
      end
    end
  end

  context "with a valid format argument" do
    it "creates successfully" do
      expect(described_class.new(format: "IMG", quantity: 2).format).to eq("IMG")
      expect(described_class.new(format: "FLAC", quantity: 2).format).to eq("FLAC")
      expect(described_class.new(format: "VID", quantity: 2).format).to eq("VID")
    end
  end

  describe "#get_minimum_bundles" do
    subject { described_class.new(format: "FLAC", quantity: quantity).get_minimum_bundles }

    let(:quantity) { 15 }

    context "when the quantity is smaller than the smallest bundle" do
      let(:quantity) { 2 }

      it "returns no bundle combination" do
        expect(subject).to eq({})
      end
    end

    context "when the quantity doesn't fit into an integer combination of bundles" do
      let(:quantity) { 19 }

      it "returns the bundle combination that achieves the largest quantity" do
        expect(subject).to eq({ 9 => 2 })
      end
    end

    it "returns a hash of the minimum number of bundles to meet the quantity" do
      expect(subject).to eq({ 9 => 1, 6 => 1 })
    end
  end

  describe "#get_cost_breakdown" do
    subject { described_class.new(format: "FLAC", quantity: 15).get_cost_breakdown }

    it "returns a hash mapping the minimum bundles to a dollar amount" do
      expect(subject).to eq({ 9 => Post::FORMAT_BUNDLES["FLAC"][9] * 1, 6 => Post::FORMAT_BUNDLES["FLAC"][6] * 1 })
    end
  end

  describe '#print_cost_breakdown' do
    subject { described_class.new(format: "FLAC", quantity: 15).print_cost_breakdown }

    it "prints a receipt of the cost breakdown for the post" do
      expect { subject }.to output("15 FLAC $1957.5\n\t1 X 9 $1147.5\n\t1 X 6 $810\n").to_stdout
    end
  end
end
