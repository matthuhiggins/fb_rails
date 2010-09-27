require 'test_helper'

class FbRails::MockTest < ActiveSupport::TestCase
  setup do
    FbRails::Mock.respond_to do |mock|
      mock.add 'lol', {}
    end
  end

  test 'weee' do
    graph = FbRails::Graph.new(FbRails::Connect.new(fb_cookie('uid' => 42, 'access_token' => 'abc')))
    graph.get 'me'
  end
  
end

FbRails::Mock.respond_to do |mock|
  mock.add '/me', {:email => 'a@b.com', :first_name => 'Matt'}
end