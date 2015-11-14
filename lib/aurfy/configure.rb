module Aurfy
  class Configure
    CREDIT_CARD_ORIGINAL_NAMES = { union_pay: "UP", visa: "VISA", jcb: "JCB", master: "MC" }

    def self.keys
      [:cardnumber, :cardtype, :charset, :cv2, :expirydate, :orderamount, :ordercurrency, :orderdescription, :orderid,
       :ordertime, :merchantid, :signmethod, :trade_certificate, :transtype, :txnremark1, :txnremark2, :version,
       :website]
    end

    def initialize(values = {})
      Configure.keys.each do |key|
        next unless value = (values[key] || default_values[key])
        instance_variable_set(:"@#{key}", value)
      end

      @cardtype = values[:card_type] || cardtype
    end

    def params
      sorted_variables.merge({ signature: signature })
    end

    def sorted_variables
      variables = instance_variables.map { |v| [v.to_s.sub("@", "").to_sym, instance_variable_get(v)] }
      Hash[variables.delete_if { |k, _| k == :trade_certificate }.sort]
    end

    def signature_key
      sorted_variables.delete_if { |k, _| k == :signmethod }.map {|p| "#{p.first}=#{p.last}" }.join("&") + "&#{@trade_certificate}"
    end

    private

    def cardtype
      card_information = credit_card_detector.detect(@cardnumber)
      CREDIT_CARD_ORIGINAL_NAMES[card_information.brand]
    end

    def credit_card_detector
      CreditCardReader::Detector.new
    end

    def default_values
      { charset:          "UTF-8",
        ordercurrency:    "USD",
        orderdescription: "",
        orderid:          DateTime.now.strftime("%Y%m%d%H%M%S%N"),
        ordertime:        DateTime.now.strftime("%Y%m%d%H%M%S"),
        signmethod:       "MD5",
        transtype:        "PURCHASE",
        txnremark1:       "",
        txnremark2:       "",
        version:          "1.0",
        website:          "" }
    end

    def signature
      Digest::MD5.hexdigest(signature_key)
    end
  end
end
