class Post
  attr_reader :format, :bundles

  FORMATS = {
    flac: "FLAC",
    img: "IMG",
    vid: "VID",
  }.freeze
  BUNDLES = {
    flac: {
      3 => 427.50,
      6 => 810,
      9 => 1147.50,
    },
    img: {
      5 => 450,
      10 => 800,
    },
    vid: {
      3 => 570,
      5 => 900,
      9 => 1530,
    },
  }.freeze

  def initialize(format:)
    @format = FORMATS[format]
    @bundles = BUNDLES[format]
  end

  def get_minimum_bundles(post_quantity)
    {
      1 => 500,
    }
  end
end
