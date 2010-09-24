module FbRails
  class Fb
    delegate :app_id, :secret, :to => 'FbRails::Config'
    delegate :connected?, :uid, :access_token, :user, :to => :connect

    attr_reader :cookies
    def initialize(cookies)
      @cookies = cookies
    end

    def graph
      @graph ||= FbRails::Graph.new(connect)
    end

    private
      def connect
        @connect ||= FbRails::Connect.new(cookies)
      end
  end
end
