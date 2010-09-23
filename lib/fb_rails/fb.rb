module FbRails
  class Fb
    delegate :app_id, :secret, :to => 'FbRails::Config'

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
