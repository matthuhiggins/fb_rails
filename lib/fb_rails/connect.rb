require 'digest/md5'

module FbRails
  class Connect
    class << self
      def cookie_name
        "fbs_#{FbRails::Config.app_id}"
      end
    end

    extend ActiveSupport::Memoizable

    attr_reader :cookies
    def initialize(cookies)
      @cookies = cookies
    end

    def cookie
      return if (cookie_string = cookies[self.class.cookie_name]).blank?

      hash = Rack::Utils::parse_query(cookie_string.gsub(/^\"|\"$/, ''))
      sorted_pairs = hash.sort
  
      payload = ''
      sorted_pairs.each do |key, value|
        payload += "#{key}=#{value}" if key != 'sig'
      end
  
      md5 = Digest::MD5.hexdigest("#{payload}#{FbRails::Config.secret}")
      if md5 == hash['sig']
        hash
      end
    end
    memoize :cookie

    def connected?
      cookie.present?
    end

    def uid
      cookie['uid'].to_i
    end

    def access_token
      cookie['access_token']
    end

    def user
      if connected?
        FbRails::Config.user_model.find_or_initialize_by_fb_uid(uid).tap do |user|
          user.fb_access_token = access_token
        end
      end
    end
    memoize :user
  end
end
