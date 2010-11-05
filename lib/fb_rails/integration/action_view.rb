module FbRails
  module Integration
    module ActionView
      def fbml(tag, content = '', options = {})
        if content.is_a?(Hash)
          options = content
          content = ''
        end

        content_tag("fb:#{tag}", content, options)
      end
    end
  end
end