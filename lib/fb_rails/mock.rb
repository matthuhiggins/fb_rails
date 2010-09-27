module FbRails
  class Mock
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
    end
  end
end