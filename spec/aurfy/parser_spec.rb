require 'spec_helper'

describe Aurfy::Parser do
  subject { described_class.new(body) }
  let(:body) { "merchantid=M000000000&orderamount=600.00&ordercurrency=USD&orderid=20150429115552415102000&ordertime=20150429115552&respcode=00&respmsg=The payment is successful.&signature=d2c4c43a7b2447d512ee3ef3c33754f4&signmethod=MD5&txnid=21150428000000006409&txnremark1=&txnremark2=&txnstatus=0&txntime=" }

  describe "#parse" do
    it "returns parsed params" do
      parsed_params = { merchantid: "M000000000", orderamount: "600.00", ordercurrency: "USD",
                        orderid: "20150429115552415102000", ordertime: "20150429115552", respcode: "00",
                        respmsg: "The payment is successful.", signature: "d2c4c43a7b2447d512ee3ef3c33754f4",
                        signmethod: "MD5", txnid: "21150428000000006409", txnremark1: "", txnremark2: "",
                        txnstatus: "0", txntime: "" }

      expect(subject.parse).to eq parsed_params
    end
  end
end
