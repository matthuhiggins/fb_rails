module FbRails
  extend ActiveSupport::Autoload

  autoload :Config
  autoload :Oauth
  autoload :Connect
  autoload :Graph
  autoload :Fb
  autoload :Mock
  autoload :Integration

  def self.cookie(uid = 42, access_token = 'abc')
    value = FbRails::Oauth.create_cookie({:uid => uid, :access_token => access_token}, FbRails::Config.secret)
    {FbRails::Connect.cookie_name => value}
  end
end

require 'fb_rails/railtie'