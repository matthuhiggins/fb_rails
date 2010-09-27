module FbRails
  extend ActiveSupport::Autoload

  autoload :Config
  autoload :Connect
  autoload :Graph
  autoload :Fb
  autoload :Helpers
  autoload :Mock
end

require 'fb_rails/railtie'