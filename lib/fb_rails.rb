module FbRails
  extend ActiveSupport::Autoload

  autoload :Config
  autoload :Cookie
  autoload :Connect
  autoload :Graph
  autoload :Fb
  autoload :Mock
  autoload :Integration
  autoload :TestHelper
end

require 'fb_rails/engine'