require 'net/http'
require 'net/https'
require 'uri'

module FbRails
  class Graph
    class << self
      def facebook_uri
        @facebook_uri ||= URI.parse('https://graph.facebook.com')
      end
    end

    attr_reader :connect
    def initialize(connect)
      @connect = connect
    end

    def post(url, params = {})
      request(:post, url, params)
    end

    def get(url, params = {})
      request(:get, url, params)
    end

    private
      def request(http_verb, url, params = {})
        path = build_path(url, params)
        response = http.send(http_verb, path)
      
        ActiveSupport::JSON.decode(response.body)
      end

      def build_path(url, params)
        params = params.merge(:access_token => connect.access_token)
        param_string = params.map { |key, value| "#{key}=#{CGI.escape(value)}" }.join('&')
        "#{url}?#{param_string}"
      end

      def http
        Net::HTTP.new(self.class.facebook_uri.host, self.class.facebook_uri.port).tap do |result|
          result.use_ssl = true
          result.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end
  end
end