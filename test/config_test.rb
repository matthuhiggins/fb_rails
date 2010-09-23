require 'test_helper'

class FbRails::ConfigTest < ActiveSupport::TestCase
  test 'user_model' do
    user_model = Class.new
  
    FbRails::Config.user_model = user_model
  
    user_model.new.tap do |user|
      assert user.respond_to?(:fb_access_token)
      assert user.respond_to?(:fb_access_token=)
    end
  end
end
