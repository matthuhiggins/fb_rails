module FbRails
  module Integration
    module ActionView
      def fbml(tag, options = nil)
        content_tag("fb:#{tag}", '', options)
      end
    end
  end
end