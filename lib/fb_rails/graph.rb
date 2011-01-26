require 'net/http'
require 'net/https'
require 'uri'
require 'fb_rails/log_subscriber'

module FbRails
  class Graph
    class << self
      def facebook_uri
        @facebook_uri ||= URI.parse('https://graph.facebook.com')
      end

      def http
        Net::HTTP.new(self.class.facebook_uri.host, self.class.facebook_uri.port).tap do |result|
          result.use_ssl = true
          result.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end

      def request(http_verb, path, params = {})
        url = build_url(path, params)

        response = ActiveSupport::Notifications.instrument('request.fb_rails') do |payload|
          payload[:http_verb]   = http_verb
          payload[:request_uri] = url
          http.send(http_verb, url)
        end

        ActiveSupport::JSON.decode(response.body)
      end

      def build_url(path, params)
        param_string = params.map { |key, value| "#{key}=#{Rack::Utils.escape(value)}" }.join('&')
        "#{path}?#{param_string}"
      end
    end

    attr_reader :connect
    def initialize(connect)
      @connect = connect
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    def get(path, params = {})
      request(:get, path, params)
    end

    private
      def request(http_verb, path, params)
        self.class.request(http_verb, path, params.merge(:access_token => connect.access_token))
      end
  end
end