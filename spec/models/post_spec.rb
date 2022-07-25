require_relative "../../src/models/post.rb"

RSpec.describe ::Post, type: :class do
  it "has all formats available for reading" do
    expect(described_class::FORMATS.length).to eq(3)
  end

  it "has all bundles available for reading" do
    expect(described_class::BUNDLES.length).to eq(3)
  end

  context "when instanced" do
    it "fails to be created if the format symbol does not exist" do
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it "creates successfully with a valid format symbol" do
      expect(described_class.new(format: :img).format).to eq("IMG")
    end
  end
end
