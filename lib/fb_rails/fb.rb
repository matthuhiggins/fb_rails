module FbRails
  class Fb
    attr_reader :cookies
    def initialize(cookies)
      @cookies = cookies
    end

    def connect
      @connect ||= FbRails::Connect.new(cookies)
    end

    def graph
      nil
    end
  end
end
