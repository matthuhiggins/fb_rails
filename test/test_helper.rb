require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :test)
require 'test/unit'

require 'sample/user'
require 'sample/test_controller'

FbRails::Config.app_id = 'foo'
FbRails::Config.secret = 'bar'

ActiveSupport::TestCase.class_eval do
  include FbRails::TestHelper
end