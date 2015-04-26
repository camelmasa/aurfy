module Aurfy
  class Configure
    def self.keys
      [:merchantid, :orderid, :ordertime, :ordercurrency, :orderamount, :orderdescription, :txnremark1, :txnremark2,
       :charset, :clientip, :version, :transtype, :website, :cardtype, :cardnumber, :cv2, :expirydate, :signmethod,
       :trade_certificate]
    end

    def initialize
      @charset          = "UTF-8"
      @ordertime        = DateTime.now.strftime("%Y%m%d%H%M%S")
      @orderid          = DateTime.now.strftime("%Y%m%d%H%M%S%N")
      @ordercurrency    = "USD"
      @orderdescription = ""
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
      instance_variables.map { |v| [v.to_s.sub("@", "").to_sym, instance_variable_get(v)] }.delete_if do
        |k, _| k == :trade_certificate
      end.sort.to_h
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
