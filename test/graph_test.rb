require 'test_helper'

class FbRails::GraphTest < ActiveSupport::TestCase
  test 'facebook_uri' do
    FbRails::Config.use_ssl = false
    assert_equal 'http', FbRails::Graph.facebook_uri.scheme

    FbRails::Config.use_ssl = true
    FbRails::Graph.instance_variable_set('@facebook_uri', nil)
    assert_equal 'https', FbRails::Graph.facebook_uri.scheme
  end
end