require 'test_helper'

class FbRails::MockTest < ActiveSupport::TestCase
  setup do
    FbRails::Mock.respond_to do |mock|
      mock.add 'test', 'foo' => 'bar'
    end
  end

  test 'mock' do
    graph = FbRails::Graph.new('my_access_token')

    result = graph.get 'test'

    assert_equal({'foo' => 'bar'}, result)
  end
end
