require 'test_helper'
require 'active_support/log_subscriber/test_helper'
require 'fb_rails/log_subscriber'

class FbRails::LogSubscriberTest < ActiveSupport::TestCase
  include ActiveSupport::LogSubscriber::TestHelper

  setup do
    FbRails::Mock.respond_to do |mock|
      mock.add 'test', 'foo' => 'bar'
    end
  end
  
  def set_logger(logger)
    # raise 'set logger'
    Rails.logger = logger
  end

  test 'request notification' do
    graph = FbRails::Graph.new(FbRails::Connect.new(fb_cookie))
    graph.get 'test'

    wait
    assert_equal 1, @logger.logged(:info).size
  end
end