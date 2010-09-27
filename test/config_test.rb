require 'test_helper'

class FbRails::ConfigTest < ActiveSupport::TestCase
  setup do
    FbRails::Config.user_class = 'Sample::TestUser'
  end

  test 'user_class' do
    FbRails::Config.user_class.new.tap do |user|
      user.fb_access_token = 'lol'
      assert user.respond_to?(:fb_access_token)
      assert user.respond_to?(:fb_access_token=)
    end
  end
end
