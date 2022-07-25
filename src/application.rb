require_relative "models/post.rb"
require_relative "models/order.rb"

class ApplicationInterface
def self.run
    puts "Enter your order below:"
    input = STDIN.gets.chomp
    order = Order.new(input: input)

    puts "Your order cost breakdown:"
    order.print_cost_breakdown
  end
end
