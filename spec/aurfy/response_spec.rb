require 'spec_helper'

describe Aurfy::Response do
  let(:response) { described_class.new(result) }

  let(:result) { double(Faraday::Response, body: "merchantid=M000000000&orderamount=600.00&ordercurrency=USD&orderid=20150429115552415102000&ordertime=20150429115552&respcode=00&respmsg=The payment is successful.&signature=d2c4c43a7b2447d512ee3ef3c33754f4&signmethod=MD5&txnid=21150428000000006409&txnremark1=&txnremark2=&txnstatus=0&txntime=") }

  it "assigns params" do
    expect(response.merchantid).to    eq "M000000000"
    expect(response.orderamount).to   eq "600.00"
    expect(response.ordercurrency).to eq "USD"
    expect(response.orderid).to       eq "20150429115552415102000"
    expect(response.ordertime).to     eq "20150429115552"
    expect(response.respcode).to      eq "00"
    expect(response.respmsg).to       eq "The payment is successful."
    expect(response.signature).to     eq "d2c4c43a7b2447d512ee3ef3c33754f4"
    expect(response.signmethod).to    eq "MD5"
    expect(response.txnid).to         eq "21150428000000006409"
    expect(response.txnremark1).to    eq ""
    expect(response.txnremark2).to    eq ""
    expect(response.txnstatus).to     eq "0"
    expect(response.txntime).to       eq ""
  end

  describe ".keys" do
    it "returns response keys" do
      keys = [:merchantid, :orderamount, :ordercurrency, :orderid, :ordertime, :respcode, :respmsg, :signature,
              :signmethod, :txnid, :txnremark1, :txnremark2, :txnstatus, :txntime]

      expect(described_class.keys).to eq keys
    end
  end

  describe "#success?" do
    context "with successful result" do
      it "returns true" do
        expect(response.success?).to be_truthy
      end
    end

    context "with failure result" do
      let(:result) { double(Faraday::Response, body: "merchantid=M000000000&orderamount=600.00&ordercurrency=USD&orderid=20150429115552415102000&ordertime=20150429115552&respcode=97&respmsg=Internal error.&signature=d2c4c43a7b2447d512ee3ef3c33754f4&signmethod=MD5&txnid=21150428000000006409&txnremark1=&txnremark2=&txnstatus=0&txntime=") }

      it "returns false" do
        expect(response.success?).to be_falsey
      end
    end
  end
end
