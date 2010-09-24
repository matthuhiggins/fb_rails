require 'net/http'
require 'net/https'
require 'uri'

module FbRails
  class Graph
    class << self
      ROOT_PATH = 'https://graph.facebook.com'
      def root_path
        ROOT_PATH
      end
    end

    attr_reader :connect
    def initialize(connect)
      @connect = connect
    end

    def post(url, params = {})
      request(Net::HTTP::Post, url, params)
    end

    def get(url, params = {})
      request(Net::HTTP::Get, url, params)
    end

    private
      def request(http_verb, url, params = {})
        params = params.merge(:access_token => connect.access_token)
        param_string = params.map { |key, value| "#{key}=#{CGI.escape(value)}" }.join('&')
        url = "#{self.class.root_path}/#{url}?#{param_string}"
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = http_verb.new(uri.request_uri)
        response = http.request(request)

        ActiveSupport::JSON.decode(response.body)
      end
  end
end