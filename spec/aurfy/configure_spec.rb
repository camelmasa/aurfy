require 'spec_helper'

describe Aurfy::Configure do
  subject { described_class.new }

  describe ".keys" do
    it "returns configure keys" do
      keys =  [:merchantid, :orderid, :ordertime, :ordercurrency, :orderamount, :orderdescription, :txnremark1,
               :txnremark2, :charset, :clientip, :version, :transtype, :website, :cardtype, :cardnumber, :cv2,
               :expirydate, :signmethod, :trade_certificate]

      expect(described_class.keys).to eq keys
    end
  end

  describe "#params" do
    it "returns configure params" do
      allow(subject).to receive(:sorted_variables) { {} }
      allow(subject).to receive(:signature) { "signature" }

      expect(subject.params).to eq({ signature: "signature" })
    end
  end

  describe "#options=" do
    it "assigns variable for option" do
      expect do
        subject.options = { merchantid: "merchantid" }
      end.to change { subject.instance_variable_get(:"@merchantid") } .from(nil).to("merchantid")
    end
  end

  describe "#sorted_variables" do
    it "returns sorted instance variables" do
      subject.options = { trade_certificate: "test", cardnumber: "0123456789012345", orderid: "orderid",
                          ordertime: "20150429124533" }
      sorted_variables = { cardnumber: "0123456789012345", cardtype: "UP", charset: "UTF-8", ordercurrency: "USD",
                           orderdescription: "", orderid: "orderid", ordertime: "20150429124533", signmethod: "MD5",
                           transtype: "PURCHASE", txnremark1: "", txnremark2: "", version: "1.0", website: "" }

      expect(subject.sorted_variables).to eq(sorted_variables)
    end
  end

  describe "#signature_key" do
    it "returns sorted instance variables" do
      subject.options = { signmethod: "MD5", trade_certificate: "trade_certificate", orderid: "orderid",
                          ordertime: "20150429124533" }
      signature_key = "cardtype=UP&charset=UTF-8&ordercurrency=USD&orderdescription=&orderid=orderid&ordertime=20150429124533&transtype=PURCHASE&txnremark1=&txnremark2=&version=1.0&website=&trade_certificate"

      expect(subject.signature_key).to eq(signature_key)
    end
  end
end
