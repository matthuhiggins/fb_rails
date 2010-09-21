module FbRails
  class Graph
    class << self
      def request(verb, url, params = {})
        url = "#{root_path}/me/friends?access_token=#{CGI.escape(access_token)}&fields=id"
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)

        yield ActiveSupport::JSON.decode(response.body)
      end

      def post(url, params = {}, &block)
        request('POST', url, params, &block)
      end

      def get(url, params = {}, &block)
        request('GET', url, params, &block)
      end

      private
        ROOT_PATH = 'https://graph.facebook.com'
        def root_path
          ROOT_PATH
        end
    end
  end
end