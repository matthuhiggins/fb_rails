module FbRails
  module Integration
    module ActionView
      def include_facebook_javascript(options = {})
        render options[:async] ? 'fb/async_js' : 'fb/blocking_js'
      end

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