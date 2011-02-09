require 'net/http'
require 'net/https'
require 'uri'
require 'fb_rails/log_subscriber'

module FbRails
  class Graph
    class << self
      def facebook_uri
        @facebook_uri ||= begin
          protocol = FbRails::Config.use_ssl ? 'https': 'http'
          URI.parse("#{protocol}://graph.facebook.com")
        end
      end

      def get(path, params = {})
        request(:get, "#{path}?#{build_param_string(params)}")
      end

      def post(path, params = {})
        request(:post, path, build_param_string(params))
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
          configure_https(result) if facebook_uri.is_a?(URI::HTTPS)
          result
        end

        def build_param_string(params)
          params.map { |key, value| "#{key}=#{Rack::Utils.escape(value)}" }.join('&')
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