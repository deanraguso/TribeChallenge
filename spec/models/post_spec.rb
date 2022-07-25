require_relative "../../src/models/post.rb"

RSpec.describe ::Post, type: :class do
  it "has all formats available for reading" do
    expect(described_class::FORMATS.length).to eq(3)
  end

  it "has all bundles available for reading" do
    expect(described_class::FORMAT_BUNDLES.length).to eq(3)
  end

  context "with NO valid format argument" do
    it "fails to be created if the format symbol does not exist" do
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it "fails to be created with a non-existent format symbol" do
      expect { described_class.new(format: :article) }.to raise_error(ArgumentError, "article is not a supported format!")
    end
  end

  context "with a valid format argument" do
    it "creates successfully" do
      expect(described_class.new(format: :img).format).to eq("IMG")
    end

    it 'contains bundles sorted by descending quantity' do
      expect(described_class.new(format: :flac).bundles).to eq(described_class::FORMAT_BUNDLES[:flac].sort.reverse)
    end
  end
end
