require 'test_helper'

class FbRails::GraphTest < ActiveSupport::TestCase
  test 'facebook_uri' do
    assert_equal 'https', FbRails::Graph.facebook_uri.scheme
  end

  test 'rescue timout error' do
    http = mock
    http.stubs(:get).raises(Timeout::Error)
    FbRails::Graph.expects(:http).returns(http)

    assert_raise FbRails::TimeoutError do
      FbRails::Graph.get 'foo'
    end
  end
end