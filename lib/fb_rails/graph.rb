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

    # "https://graph.facebook.com/me?access_token=#{token}"
    def request(verb, url, params = {})
      url = "#{root_path}/me/friends?access_token=#{CGI.escape(access_token)}"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      ActiveSupport::JSON.decode(response.body)
    end

    def post(url, params = {})
      request('POST', url, params)
    end

    def get(url, params = {})
      request('GET', url, params)
    end

  end
end