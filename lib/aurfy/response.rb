module Aurfy
  class Response
    attr_reader :result, :merchantid, :orderamount, :ordercurrency, :orderid, :ordertime, :respcode, :respmsg,
                :signature, :signmethod, :txnid, :txnremark1, :txnremark2, :txnstatus, :txntime

    def self.keys
      [:merchantid, :orderamount, :ordercurrency, :orderid, :ordertime, :respcode, :respmsg, :signature, :signmethod,
       :txnid, :txnremark1, :txnremark2, :txnstatus, :txntime]
    end

    def initialize(result)
      @result = result

      parsed_params = Parser.new(result.body).parse
      assign_variables(parsed_params)
    end

    def success?
      respcode == "00"
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
