module Aurfy
  class Configure
    def self.keys
      [:merchantid, :orderid, :ordertime, :ordercurrency, :orderamount, :orderdescription, :txnremark1, :txnremark2,
       :charset, :clientip, :version, :transtype, :website, :cardtype, :cardnumber, :cv2, :expirydate, :signmethod,
       :trade_certificate]
    end

    def initialize
      @cardtype         = "UP"
      @charset          = "UTF-8"
      @ordercurrency    = "USD"
      @orderdescription = ""
      @orderid          = DateTime.now.strftime("%Y%m%d%H%M%S%N")
      @ordertime        = DateTime.now.strftime("%Y%m%d%H%M%S")
      @signmethod       = "MD5"
      @transtype        = "PURCHASE"
      @txnremark1       = ""
      @txnremark2       = ""
      @version          = "1.0"
      @website          = ""
    end

    def params
      sorted_variables.merge({ signature: signature })
    end

    def options=(options = {})
      options.each_pair do |key, value|
        next unless Configure.keys.include? key
        instance_variable_set(:"@#{key}", value)
      end
      options
    end

    def sorted_variables
      variables = instance_variables.map { |v| [v.to_s.sub("@", "").to_sym, instance_variable_get(v)] }
      Hash[variables.delete_if { |k, _| k == :trade_certificate }.sort]
    end

    def signature_key
      sorted_variables.delete_if { |k, _| k == :signmethod }.map {|p| "#{p.first}=#{p.last}" }.join("&") + "&#{@trade_certificate}"
    end

    private

    def signature
      Digest::MD5.hexdigest(signature_key)
    end
  end
end
