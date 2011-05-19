require 'net/http'
require 'net/https'
require 'uri'
require 'fb_rails/log_subscriber'

module FbRails
  class Graph
    class << self
      def facebook_uri
        @facebook_uri ||= URI.parse("https://graph.facebook.com")
      end

      def get(path, params = {})
        request(:get, "#{path}?#{params.to_param}")
      end

      def post(path, params = {})
        request(:post, path, params.to_param)
      end

      private
        def request(http_verb, path, *arguments)
          response = ActiveSupport::Notifications.instrument('request.fb_rails') do |payload|
            payload[:http_verb]   = http_verb
            payload[:request_uri] = path
            http.send(http_verb, path, *arguments)
          end

          ActiveSupport::JSON.decode(response.body)
        end

        def http
          result = Net::HTTP.new(facebook_uri.host, facebook_uri.port)
          configure_https(result)
          result
        end

        def configure_https(http)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
    end

    attr_reader :access_token
    def initialize(access_token)
      @access_token = access_token
    end

    def post(path, params = {})
      self.class.post(path, params.merge(:access_token => access_token))
    end

    def get(path, params = {})
      self.class.get(path, params.merge(:access_token => access_token))
    end
  end
end