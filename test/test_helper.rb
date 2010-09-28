require 'rubygems'
require 'test/unit'
require 'rails/all'

require 'fb_rails'

require 'sample/test_user'
require 'sample/test_controller'

FbRails::Config.app_id = 'foo'
FbRails::Config.secret = 'bar'

module ActiveSupport
  TestCase.class_eval do
    def fb_cookie(uid = 42, access_token = 'abc')
      param_string = "uid=#{uid}&access_token=#{access_token}"
      payload = "access_token=#{access_token}uid=#{uid}"
      sig = Digest::MD5.hexdigest("#{payload}#{FbRails::Config.secret}")
      {FbRails::Connect.cookie_name => "\"#{param_string}&sig=#{sig}\""}
    end
  end
end

