module FbRails
  module Helpers
    module ActionController
      extend ActiveSupport::Concern

      included do
        helper_method :fb
      end

      private
        def fb
          @fb ||= ::FbRails::Fb.new(cookies)
        end
    end
  end
end