require 'spec_helper'

describe Aurfy::Client do
  subject { described_class.new("merchant_id", "trade_certificate") }

  describe "#initialize" do
    it "assigns parameters for payment" do
      expect(subject.merchantid).to eq "merchant_id"
      expect(subject.trade_certificate).to eq "trade_certificate"
      expect(subject.api_url).to eq Aurfy::API_URL
    end

    context "with test argumaent" do
      subject { described_class.new("merchant_id", "trade_certificate", true) }

      it "assigns parameters for payment" do
        expect(subject.merchantid).to eq "merchant_id"
        expect(subject.trade_certificate).to eq "trade_certificate"
        expect(subject.api_url).to eq Aurfy::TEST_API_URL
      end
    end
  end

  describe "#request" do
    context "with valid credit card" do
      it "returns successful Aurfy::Response instance" do
        response = double(Faraday::Response, body: "merchantid=M000000000&orderamount=600.00&ordercurrency=USD&orderid=20150429115552415102000&ordertime=20150429115552&respcode=00&respmsg=The payment is successful.&signature=d2c4c43a7b2447d512ee3ef3c33754f4&signmethod=MD5&txnid=21150428000000006409&txnremark1=&txnremark2=&txnstatus=0&txntime=")
        allow_any_instance_of(Faraday).to receive(:post) { response }

        expect(subject.request).to be_a Aurfy::Response
      end
    end
  end
end
