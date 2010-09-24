require 'test_helper'

class FbRails::FbTest < ActiveSupport::TestCase
  test 'configuration' do
    fb = FbRails::Fb.new({})

    assert_equal FbRails::Config.app_id, fb.app_id
    assert_equal FbRails::Config.secret, fb.secret
  end

  test 'connect delegation' do
    fb = FbRails::Fb.new(fb_cookie('uid' => 42, 'access_token' => 'abc'))

    assert fb.respond_to?(:connected?)
    assert fb.respond_to?(:uid)
    assert fb.respond_to?(:access_token)
    assert fb.respond_to?(:user)
  end

  test 'graph' do
    fb = FbRails::Fb.new({})

    assert_kind_of FbRails::Graph, fb.graph
    assert_equal fb.graph.object_id, fb.graph.object_id    
  end
end