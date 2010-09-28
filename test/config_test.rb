require 'test_helper'

class FbRails::ConfigTest < ActiveSupport::TestCase
  test 'user_class' do
    assert_equal User, FbRails::Config.user_class
  end
end
