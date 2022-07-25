class Order
  attr_reader :posts

  def initialize(input:)
    validate_input!
  end

  private

  def validate_input!(input:)
    input_array = input.split(" ")

    unless ((input_array.length > 0) && ((input_array % 2) == 0))
      raise ArgumentError.new("input is not of the correct format!")
    end
  end

  def get_posts(input:)
  end
end
