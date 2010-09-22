module FbRails
  module Helpers
    extend ActiveSupport::Autoload

    autoload :ActionController
    autoload :ActionView
    autoload :ActiveRecord
  end
end
