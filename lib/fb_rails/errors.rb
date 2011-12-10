module FbRails
  class GraphError < StandardError
    def initialize(message)
      @message = message
    end
    def to_s; @message ;end
  end

  class TimeoutError < GraphError
  end

  class ResponseError < GraphError
  end
end