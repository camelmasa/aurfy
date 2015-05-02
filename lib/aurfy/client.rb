module Aurfy
  API_URL      = "https://pgw.aurfy.com/v2/api/purchase/express"
  TEST_API_URL = "http://test-pgw.comconnpay.com/v2/api/purchase/express"

  class Client
    attr_reader :api_url, :merchantid, :trade_certificate

    def initialize(merchantid, trade_certificate, test = false)
      @api_url = test ? TEST_API_URL : API_URL
      @merchantid = merchantid
      @trade_certificate = trade_certificate
    end

    def request(options = {})
      configure.options = options.merge(merchantid: merchantid, trade_certificate: trade_certificate)

      result = Faraday.post @api_url, configure.params
      Response.new(result)
    end

    def configure
      @configure ||= Configure.new
    end
  end
end
