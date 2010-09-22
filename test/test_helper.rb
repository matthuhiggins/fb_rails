require 'rubygems'
require 'test/unit'
require 'rails/all'

require 'fb_rails'

require 'sample/test_user'
require 'sample/test_controller'

FbRails::Config.app_id = 'foo'
FbRails::Config.secret = 'bar'
FbRails::Config.user_model = Sample::TestUser
