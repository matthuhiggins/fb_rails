require 'test_helper'

class FbRails::MockTest < ActiveSupport::TestCase
  setup do
    FbRails::Mock.respond_to do |mock|
      mock.add 'test', 'foo' => 'bar'
    end
  end

  test 'mock' do
    assert_equal({'foo' => 'bar'},  FbRails::Graph.get('test'))
    assert_equal({'foo' => 'bar'},  FbRails::Graph.post('test', 'foo' => 'bar'))
  end
end
