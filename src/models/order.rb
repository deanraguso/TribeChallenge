require_relative "./post.rb"

class Order
  attr_reader :posts

  def initialize(input:)
    validate_input!(input: input)

    @posts = get_posts(input: input)
  end

  def print_cost_breakdown
    @posts.map(&:print_cost_breakdown)
  end

  private

  def validate_input!(input:)
    input_array = input.split(" ")

    unless ((input_array.length > 0) && ((input_array.length % 2) == 0))
      raise ArgumentError.new("input is not of the correct format!")
    end
  end

  def get_posts(input:)
    posts = []

    input_array = input.split(" ")
    while (post_order = input_array.slice!(-2, 2))
      validate_post_order!(quantity: post_order[0], format: post_order[1].upcase)

      posts << Post.new(quantity: post_order[0].to_i, format: post_order[1].upcase)
    end

    posts
  end

  def validate_post_order!(quantity:, format:)
    unless ((quantity.to_i.to_s == quantity) && (quantity.to_i > 0))
      raise ArgumentError.new("#{quantity} is not an integer greater than 0!")
    end

    unless Post::FORMATS.include?(format)
      raise ArgumentError.new("#{format} is not a supported format!")
    end
  end
end
