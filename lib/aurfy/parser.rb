module Aurfy
  class Parser
    attr_reader :body

    def initialize(body)
      @body = body
    end

    def parse
      params = body.split("&").map { |p| p.split("=") }
      params = params.map { |p| p.length >= 2 ? p : p.push("") }
      Hash[params].each_with_object({}) { |(k, v), a| a[k.to_s.to_sym] = v }
    end
  end
end
