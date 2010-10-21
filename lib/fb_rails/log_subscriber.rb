module FbRails
  class LogSubscriber < ActiveSupport::LogSubscriber
    def request(event)
      name = color('FbRails (%.1fms)' % event.duration, CYAN, true)
      info "  #{name}  #{event.payload[:http_verb].to_s.upcase} #{event.payload[:request_uri]}"
    end

    def logger
      Rails.logger
    end
  end
end

FbRails::LogSubscriber.attach_to :fb_rails