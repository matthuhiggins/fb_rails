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

    def app_id
      FbRails::Config.app_id
    end

    def secret
      FbRails::Config.secret
    end
  end
end
