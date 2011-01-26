module FbRails
  class Mock
    class Response
      attr_reader :body
      def initialize(data)
        @body = data.to_json
      end
    end

    class Responder
      attr_reader :responses
      def initialize(responses)
        @responses = responses
      end

      def add(path, data)
        responses[path] = Response.new(data)
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

      def find_response(path)
        path = path.gsub(/\?.*$/, '')
        responses[path]
      end
    end

    %w(get post).each do |method|
      module_eval <<-EOE, __FILE__, __LINE__ + 1
        def #{method}(path)
          self.class.find_response(path)
        end
      EOE
    end
  end

  class Graph
    def self.http
      @http ||= Mock.new
    end
  end
end