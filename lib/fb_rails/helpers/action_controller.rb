module FbRails
  module Helpers
    module ActionController
      extend ActiveSupport::Concern

      included do
        helper_method :fb_connect
      end

      private
        def fb_connect
          @fb_connect ||= ::FbRails::Connect.new(cookies)
        end
    end
  end
end