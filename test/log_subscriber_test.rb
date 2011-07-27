require 'test_helper'
require 'active_support/log_subscriber/test_helper'
require 'fb_rails/log_subscriber'

class FbRails::LogSubscriberTest < ActiveSupport::TestCase
  include ActiveSupport::LogSubscriber::TestHelper

  def setup
    super

    FbRails::Mock.respond_to do |mock|
      mock.add 'test', 'foo' => 'bar'
    end

    FbRails::LogSubscriber.attach_to :fb_rails
  end

  test 'request notification' do
    graph = FbRails::Graph.new('my_access_token')
    graph.get 'test'

    wait
    assert_equal 1, @logger.logged(:info).size
    assert_match /FbRails \(\d+.\d+ms\) GET test/, @logger.logged(:info).first
  end
end