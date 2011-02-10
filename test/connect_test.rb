require 'test_helper'

class FbRails::ConnectTest < ActiveSupport::TestCase
  test 'empty cookie' do
    fb_connect = FbRails::Connect.new({})

    assert !fb_connect.connected?
    assert_nil fb_connect.user
    assert_nil fb_connect.uid
    assert_nil fb_connect.access_token
  end

  test 'invalid signature' do
    cookies = {FbRails::Connect.cookie_name => "\"uid=42&sig=invalid\""}
    fb_connect = FbRails::Connect.new(cookies)

    assert !fb_connect.connected?
    assert_nil fb_connect.user
  end

  test 'valid cookie' do
    fb_connect = FbRails::Connect.new(fb_cookie(7, 'abc'))

    assert fb_connect.connected?
    assert_equal 7, fb_connect.uid
    assert_equal 'abc', fb_connect.access_token
    assert_not_nil fb_connect.user
    assert_equal 7, fb_connect.uid
  end

  test 'user' do
    fb_connect = FbRails::Connect.new(fb_cookie(7, 'abc'))

    user = fb_connect.user
    assert_equal 7, fb_connect.user.fb_uid
    assert_equal 'abc', fb_connect.user.access_token
  end
end
