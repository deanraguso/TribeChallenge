## Use

## Overview

Clients can create orders for social media content created by influencers, they must purchase the material in bundles.

This application calculates the total price for the posts required, and presents the cost breakdown according to the packages that make up the order.

## Assumptions

- Clients will input their order in a space separated string, with the format "quantity product".
- The input order can chain on indefinitely.
- The product order will be organised to require the minimum number of packages for each format.
- The submission format catalogue is static.

Example Case:
```rb
//  Input
10 IMG 15 FLAC 13 VID

//  Output
10 IMG $800
    1 X 10 $800
15 FLAC $1957.50
    1 X 9 $1147.50
    1 X 6 $810
13 VID $2370
    2 X 5 $1800
    1 X 3 $570
```
