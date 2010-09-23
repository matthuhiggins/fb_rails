require 'test_helper'

class FbRails::FbTest < ActiveSupport::TestCase
  test 'connect' do
    fb = FbRails::Fb.new(fb_cookie('uid' => 42, 'access_token' => 'abc'))

    assert_kind_of FbRails::Connect, fb.connect
    assert_equal fb.connect.object_id, fb.connect.object_id
  end
end