require 'test_helper'

class FbRails::Integration::ActionViewTest < ActiveSupport::TestCase
  include ActionView::Helpers::TagHelper
  include FbRails::Integration::ActionView

  test 'fbml' do
    assert_equal '<fb:foo></fb:foo>', fbml('foo')
    assert_equal '<fb:foo>bar</fb:foo>', fbml('foo', 'bar')
    assert_equal '<fb:foo faz="baz"></fb:foo>', fbml('foo', 'faz' => 'baz')
    assert_equal '<fb:foo faz="baz">bar</fb:foo>', fbml('foo', 'bar', 'faz' => 'baz')
  end
end