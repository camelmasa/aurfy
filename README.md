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
merchantid = "M000000000"
trade_certificate = "D0123456789012345678901234567789"
cardnumber = "0123456789012345"
expirydate = "1701"
cv2 = "123"
cardtype = "UP"
orderamount = "100.00"
clientip = "192.168.0.1"

client = Aurfy::Client.new(
  test: true,
  merchantid: merchantid,
  trade_certificate: trade_certificate
)

client.request(
  cardnumber: cardnumber,
  expirydate: expirydate,
  cv2: cv2,
  cardtype: cardtype,
  orderamount: orderamount,
  clientip: clientip
)
```

Test
----

```
bundle exec rspec
```
