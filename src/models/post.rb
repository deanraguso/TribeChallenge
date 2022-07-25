class Post
  attr_reader :format, :bundles

  FORMATS = {
    flac: "FLAC",
    img: "IMG",
    vid: "VID",
  }.freeze
  FORMAT_BUNDLES = {
    flac: {
      3 => 427.50,
      6 => 810,
      9 => 1147.50,
    }.freeze,
    img: {
      5 => 450,
      10 => 800,
    }.freeze,
    vid: {
      3 => 570,
      5 => 900,
      9 => 1530,
    }.freeze,
  }.freeze

  def initialize(format:)
    validate_format!(format: format)

    @format = FORMATS[format]
    @bundles = FORMAT_BUNDLES[format]
  end

  def get_minimum_bundles(quantity:)
    validate_quantity!(quantity: quantity)

    remaining = quantity
    bundles.sort.reverse.map { |bundle|
      hcf, remainder = highest_common_factor(remaining, bundle[0])
      remaining = remainder

      [bundle[0], hcf]
    }.to_h.delete_if { |k, v| v == 0 }
  end

  private

  def validate_format!(format:)
    raise ArgumentError.new("#{format} is not a supported format!") unless FORMATS.include?(format)
  end

  def validate_quantity!(quantity:)
    unless quantity >= 0
      raise ArgumentError.new("#{quantity} is not a valid quantity!")
    end
  end

  def highest_common_factor(quantity, divisor)
    hcf = (quantity / divisor).to_i
    remainder = quantity - (divisor * hcf)

    [hcf, remainder]
  end
end
