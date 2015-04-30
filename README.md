# aurfy

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
merchant_id       = "M000000000"
trade_certificate = "D0123456789012345678901234567890"

client = Aurfy::Client.new(merchant_id, trade_certificate)

client.request(
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
