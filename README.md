## Use

1. Run `rake` or `rake run` inside the `TribeChallenge` directory.
2. Input a post order in the following format:
`Quantity Format`
  - Format must be either: FLAC / IMG / VIDEO
3. Press enter - the output will be printed below.

## Overview

Clients can create orders for social media content created by influencers, they must purchase the material in bundles.

This application calculates the total price for the posts required, and presents the cost breakdown according to the packages that make up the order.

## Assumptions

- Clients will input their order in a space separated string, with the format "quantity product".
- The input order can chain on indefinitely.
- The submission format catalogue is static.
- The product order will be organised to require the minimum number of packages for each format.
- **Only an integer number of each bundle can be bought**
  - If less than the quantity of the smallest bundle is requested, the order quantity will round down to the maximum achievable order size.

Example Case:
```rb
#  Input
10 IMG 15 FLAC 13 VID

#  Output
10 IMG $800
    1 X 10 $800
15 FLAC $1957.50
    1 X 9 $1147.50
    1 X 6 $810
13 VID $2370
    2 X 5 $1800
    1 X 3 $570
```

## Test Coverage

- I have used unit testing throughout, focussing particularly on areas where validation is used and data format matters.
- I have also used some integration testing, going as far as the input to the object and the output to the console. Taking it one step further - this could be extended even to test the user input.

```rb
Order
  with an invalid input
    when the input argument structure is invalid
      raises an argument error
    when a quantity isn't a positive integer
      raises an argument error
    when the format isn't valid
      raises an argument error
  with a valid input
    creates a list of valid posts
  #print_cost_breakdown
    prints a receipt of the cost breakdown for the order

Post
  has all formats available for reading
  has all bundles available for reading
  with invalid params
    when the format is invalid
      fails to be created
    when quantity is invalid
      fails to be created
  with a valid format argument
    creates successfully
  #get_minimum_bundles
    returns a hash of the minimum number of bundles to meet the quantity
    when the quantity is smaller than the smallest bundle
      returns no bundle combination
    when the quantity doesn't fit into an integer combination of bundles
      returns the bundle combination that achieves the largest quantity
  #get_cost_breakdown
    returns a hash mapping the minimum bundles to a dollar amount
  #print_cost_breakdown
    prints a receipt of the cost breakdown for the post

```
