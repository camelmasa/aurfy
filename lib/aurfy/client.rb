module Aurfy
  API_URL      = "https://pgw.aurfy.com/v2/api/purchase/express"
  TEST_API_URL = "http://test-pgw.comconnpay.com/v2/api/purchase/express"

  attr_reader :api_url

  class Client
    def initialize(merchantid, trade_certificate, test = false)
      @api_url = test ? API_URL : TEST_API_URL
    end

    def request(options = {})
      configure.options = options

      result = Faraday.post @api_url, configure.params
      Response.new(result)
    end

    private

    def configure
      @configure ||= Configure.new
    end
  end
end
