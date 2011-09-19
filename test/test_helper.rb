require 'rubygems'
require 'bundler/setup'

require 'test/unit'
require 'rails/all'
require 'fb_rails'
require 'mocha'

require 'sample/user'
require 'sample/test_controller'

FbRails::Config.app_id = 'foo'
FbRails::Config.secret = 'bar'

ActiveSupport::TestCase.class_eval do
  include FbRails::TestHelper
end