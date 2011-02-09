require 'test_helper'

class FbRails::GraphTest < ActiveSupport::TestCase
  test 'facebook_uri' do
    assert_equal 'https', FbRails::Graph.facebook_uri.scheme
  end
end