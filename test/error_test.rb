require 'test_helper'

class FbRails::ErrorTest < ActiveSupport::TestCase
  test 'to_s' do
    assert_equal 'hello', FbRails::GraphError.new('hello').to_s
  end
end