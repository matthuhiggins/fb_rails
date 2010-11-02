module FbRails
  extend ActiveSupport::Autoload

  autoload :Config
  autoload :Oauth
  autoload :Connect
  autoload :Graph
  autoload :Fb
  autoload :Mock
  autoload :Integration
end

require 'fb_rails/railtie'