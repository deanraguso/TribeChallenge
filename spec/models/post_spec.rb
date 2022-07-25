require_relative "../../src/models/post.rb"

RSpec.describe ::Post, type: :class do
  it "has all formats available for reading" do
    expect(described_class::FORMATS.length).to eq(3)
  end

  it "has all bundles available for reading" do
    expect(described_class::FORMAT_BUNDLES.length).to eq(3)
  end

  context "with invalid params" do
    context "with an invalid or missing format argument" do
      it "fails to be created" do
        expect { described_class.new(format: :article, quantity: 2) }.to raise_error(ArgumentError, "article is not a supported format!")
      end
    end

    context "with an invalid quantity" do
      it "fails to be created" do
        expect { described_class.new(format: :flac, quantity: 27.5) }.to raise_error(ArgumentError, "27.5 is not an integer greater than 0!")
      end
    end
  end

  context "with a valid format argument" do
    it "creates successfully" do
      expect(described_class.new(format: :img, quantity: 2).format).to eq("IMG")
    end
  end

  describe "#get_minimum_bundles" do
    subject { described_class.new(format: :flac, quantity: quantity).get_minimum_bundles }

    context "with a valid quantity" do
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
  end
end
