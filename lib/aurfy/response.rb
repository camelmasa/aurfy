module Aurfy
  class Response
    attr_reader :response, :merchantid, :orderamount, :ordercurrency, :orderid, :ordertime, :respcode, :respmsg,
                :signature, :signmethod, :txnid, :txnremark1, :txnremark2, :txnstatus, :txntime

    def self.keys
      [:merchantid, :orderamount, :ordercurrency, :orderid, :ordertime, :respcode, :respmsg, :signature, :signmethod,
       :txnid, :txnremark1, :txnremark2, :txnstatus, :txntime]
    end

    def initialize(response)
      @response = response

      parsed_params = Parser.new(response.body).parse
      assign_variables(parsed_params)
    end

    def success?
      respcode === "00"
    end

    private

    def assign_variables(params)
      params.each_pair do |key, value|
        next unless Response.keys.include? key
        instance_variable_set(:"@#{key}", value)
      end
    end
  end
end
