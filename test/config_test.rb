require 'test_helper'

class FbRails::ConfigTest < ActiveSupport::TestCase
  test 'user_class' do
    assert_equal User, FbRails::Config.user_class
    assert User.new.respond_to?(:access_token)
  end
  
  test 'default timeout' do
    assert_equal 60, FbRails::Config.timeout
  end
end
