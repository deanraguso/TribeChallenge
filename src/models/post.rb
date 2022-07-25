class Post
  attr_reader :format, :bundles, :quantity, :get_cost_breakdown

  FORMATS = ["FLAC", "IMG", "VID"].freeze
  FORMAT_BUNDLES = {
    "FLAC" => {
      3 => 427.50,
      6 => 810,
      9 => 1147.50,
    }.freeze,
    "IMG" => {
      5 => 450,
      10 => 800,
    }.freeze,
    "VID" => {
      3 => 570,
      5 => 900,
      9 => 1530,
    }.freeze,
  }.freeze

  def initialize(format:, quantity:)
    validate_format!(format: format)
    validate_quantity!(quantity: quantity)

    @format = format
    @quantity = quantity
    @bundles = FORMAT_BUNDLES[format]
  end

  def print_cost_breakdown
    minimum_bundles = get_minimum_bundles
    cost_breakdown = get_cost_breakdown
    total_cost = get_total_cost(cost_breakdown: cost_breakdown)

    puts "#{@quantity} #{@format} $#{total_cost}"
    minimum_bundles.each { |bundle|
      bundle_size, quantity = bundle

      puts "\t#{quantity} X #{bundle_size} $#{cost_breakdown[bundle_size]}"
    }
  end

  def get_cost_breakdown
    get_minimum_bundles.map { |bundle|
      bundle_size, quantity = bundle

      [bundle_size, quantity * @bundles[bundle_size]]
    }.to_h
  end

  def get_minimum_bundles
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
    unless ((quantity.to_s.to_i == quantity) && (quantity.to_i > 0))
      raise ArgumentError.new("#{quantity} is not an integer greater than 0!")
    end
  end

  def highest_common_factor(quantity, divisor)
    hcf = (quantity / divisor).to_i
    remainder = quantity - (divisor * hcf)

    [hcf, remainder]
  end

  def get_total_cost(cost_breakdown:)
    cost_breakdown.reduce(0) { |total_cost, bundle| total_cost + bundle[1] }
  end
end
