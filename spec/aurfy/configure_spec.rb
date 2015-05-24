require 'spec_helper'

describe Aurfy::Configure do
  let(:configure) { described_class.new }

  describe ".keys" do
    it "returns configure keys" do
     keys = [:cardnumber, :cardtype, :charset, :cv2, :expirydate, :orderamount, :ordercurrency, :orderdescription, :orderid,
             :ordertime, :merchantid, :signmethod, :trade_certificate, :transtype, :txnremark1, :txnremark2, :version,
             :website]

      expect(described_class.keys).to eq keys
    end
  end

  describe "#params" do
    it "returns configure params" do
      allow(configure).to receive(:sorted_variables) { {} }
      allow(configure).to receive(:signature) { "signature" }

      expect(configure.params).to eq({ signature: "signature" })
    end
  end

  describe "#sorted_variables" do
    it "returns sorted instance variables" do
      configure = described_class.new(trade_certificate: "test", cardnumber: "6200123456789012", orderid: "orderid",
                                       ordertime: "20150429124533")
      sorted_variables = { cardnumber: "6200123456789012", cardtype: "UP", charset: "UTF-8", ordercurrency: "USD",
                           orderdescription: "", orderid: "orderid", ordertime: "20150429124533", signmethod: "MD5",
                           transtype: "PURCHASE", txnremark1: "", txnremark2: "", version: "1.0", website: "" }

      expect(configure.sorted_variables).to eq(sorted_variables)
    end
  end

  describe "#signature_key" do
    it "returns sorted instance variables" do
      configure = described_class.new(cardnumber: "6200123456789012", signmethod: "MD5",
                                      trade_certificate: "trade_certificate", orderid: "orderid",
                                      ordertime: "20150429124533")
      signature_key = "cardnumber=6200123456789012&cardtype=UP&charset=UTF-8&ordercurrency=USD&orderdescription=&orderid=orderid&ordertime=20150429124533&transtype=PURCHASE&txnremark1=&txnremark2=&version=1.0&website=&trade_certificate"

      expect(configure.signature_key).to eq(signature_key)
    end
  end
end
