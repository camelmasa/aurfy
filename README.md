# aurfy

[![Build Status](https://travis-ci.org/camelmasa/aurfy.png)](https://travis-ci.org/camelmasa/aurfy)
[![Code Climate](https://codeclimate.com/github/camelmasa/aurfy/badges/gpa.svg)](https://codeclimate.com/github/camelmasa/aurfy)
[![Test Coverage](https://codeclimate.com/github/camelmasa/aurfy/badges/coverage.svg)](https://codeclimate.com/github/camelmasa/aurfy)

Ruby client for [Aurfy](http://www.aurfy.com/)

Instration
----------

Add this line to your application's Gemfile:

    gem 'aurfy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aurfy

Usage
-----

```rb
require "aurfy"

options = {
  merchantid: "M000000000",
  trade_certificate: "D0123456789012345678901234567890",
  test: false
}

client = Aurfy::Client.new(options)

client.purchase(
  cardnumber:  "0123456789012345",
  expirydate:  "1701",
  cv2:         "123",
  orderamount: "100.00",
  clientip:    "192.168.0.1"
)
```

Test
----

```
bundle exec rspec
```
