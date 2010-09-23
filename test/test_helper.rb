require 'rubygems'
require 'test/unit'
require 'rails/all'

require 'fb_rails'

require 'sample/test_user'
require 'sample/test_controller'

FbRails::Config.app_id = 'foo'
FbRails::Config.secret = 'bar'
FbRails::Config.user_model = Sample::TestUser

module ActiveSupport
  TestCase.class_eval do
    def fb_cookie(params)
      param_string = params.map { |name, value| "#{name}=#{value}" }.join('&')
      payload = params.sort.map { |name, value| "#{name}=#{value}" }.join
      sig = Digest::MD5.hexdigest("#{payload}#{FbRails::Config.secret}")
      {FbRails::Connect.cookie_name => "\"#{param_string}&sig=#{sig}\""}
    end
  end
end

