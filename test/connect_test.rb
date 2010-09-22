require 'test_helper'

class FbRails::ConnectTest < ActiveSupport::TestCase
  test 'empty cookie' do
    fb_connect = FbRails::Connect.new({})
    assert !fb_connect.connected?
  end

  test 'invalid signature' do
    cookies = {FbRails::Connect.cookie_name => "\"uid=42&sig=invalid\""}
    fb_connect = FbRails::Connect.new(cookies)

    assert !fb_connect.connected?
  end

  test 'valid cookie' do
    cookies = {FbRails::Connect.cookie_name => fb_cookie_value(42)}
    fb_connect = FbRails::Connect.new(cookies)

    assert fb_connect.connected?
    assert_equal 42, fb_connect.uid
  end

  private
    def fb_cookie_value(fb_uid)
      payload = "uid=#{fb_uid}"
      sig = Digest::MD5.hexdigest("#{payload}#{FbRails::Config.secret}")
      "\"uid=#{fb_uid}&sig=#{sig}\""
    end
end
