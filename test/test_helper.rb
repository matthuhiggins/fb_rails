require 'rubygems'
require 'test/unit'
require 'rails/all'

require 'fb_rails'

require 'sample/user'
require 'sample/test_controller'

FbRails::Config.app_id = 'foo'
FbRails::Config.secret = 'bar'

FbRails.class_eval do
  def self.cookie(uid = 42, access_token = 'abc')
    value = FbRails::Oauth.create_cookie({:uid => uid, :access_token => access_token}, FbRails::Config.secret)
    {FbRails::Connect.cookie_name => value}
  end
end