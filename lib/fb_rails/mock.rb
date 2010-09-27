module FbRails
  class Mock
    class Response
      attr_reader :body
      def initialize(body)
        @body = body
      end
    end

    class Responder
      attr_reader :responses
      def initialize(responses)
        @responses = responses
      end

      def add(path, response)
        responses[path] = response
      end
    end

    class << self
      def responses
        @@responses ||= {}
      end

      def respond_to
        yield Responder.new(responses)
      end

      def reset!
        responses.clear
      end
    end

    def get(path)
      p "path = #{path}"
      Response.new({'hello' => 'world'}.to_json)
    end
  end

  class Graph
    private
      def http
        @http ||= Mock.new
      end
  end
end