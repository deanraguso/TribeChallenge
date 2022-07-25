require_relative "models/post.rb"
require_relative "models/order.rb"

puts "Enter your order below:"
input = gets.chomp

order = Order.new(input: input)

puts "Your order cost breakdown:"
order.print_cost_breakdown
