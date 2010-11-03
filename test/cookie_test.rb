require 'test_helper'

class FbRails::CookieTest < ActiveSupport::TestCase
  test 'decode' do
    assert_equal(
      {'a' => '1', 'b' => '2', 'sig' => '25a7f94742b4134695b80f78d4804e35'},
      FbRails::Cookie.decode("\"a=1&b=2&sig=25a7f94742b4134695b80f78d4804e35\"", 'sekrit')
    )
  end

  test 'decode invalid' do
    assert_nil FbRails::Cookie.decode("\"a=1&b=2&sig=invalid\"", 'sekrit')
  end

  test 'encode' do
    assert_equal(
      "\"a=1&b=2&sig=25a7f94742b4134695b80f78d4804e35\"",
      FbRails::Cookie.encode({:a => 1, :b => 2}, 'sekrit')
    )
  end
end