module Aurfy
  class Parser
    attr_reader :body

    def initialize(body)
      @body = body
    end

    def parse
      Rack::Utils.parse_nested_query(body).symbolize_keys
    end
  end
end
