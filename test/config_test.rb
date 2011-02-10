require 'test_helper'

class FbRails::ConfigTest < ActiveSupport::TestCase
  test 'user_class' do
    assert_equal User, FbRails::Config.user_class
    assert User.new.respond_to?(:access_token)
  end
end
