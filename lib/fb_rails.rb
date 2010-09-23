module FbRails
  extend ActiveSupport::Autoload

  autoload :Config
  autoload :Connect
  autoload :Graph
  autoload :Fb
  autoload :Helpers
end

require 'fb_rails/railtie'