require 'digest/md5'

module FbRails
  class Connect
    class << self
      def cookie_name
        "fbs_#{FbRails::Config.app_id}"
      end

      def parse_oauth2_cookie(cookie_string, secret)
        return if cookie_string.blank?

        hash = Rack::Utils::parse_query(cookie_string.gsub(/^\"|\"$/, ''))

        payload = ''
        hash.sort.each do |key, value|
          payload += "#{key}=#{value}" if key != 'sig'
        end

        md5 = Digest::MD5.hexdigest("#{payload}#{secret}")
        if md5 == hash['sig']
          hash
        end
      end

      def create_oauth2_cookie(attributes, secret)
        sorted_pairs = attributes.sort.map { |key, value| "#{key}=#{value}" }
        param_string = sorted_pairs.join('&')
        payload = sorted_pairs.join('')
        sig = Digest::MD5.hexdigest("#{payload}#{FbRails::Config.secret}")
        "\"#{param_string}&sig=#{sig}\""
      end
    end

    extend ActiveSupport::Memoizable

    attr_reader :cookies
    def initialize(cookies)
      @cookies = cookies
    end

    def cookie
      self.class.parse_oauth2_cookie(cookies[self.class.cookie_name], FbRails::Config.secret)
    end
    memoize :cookie

    def connected?
      cookie.present?
    end

    def uid
      connected? ? cookie['uid'].to_i : nil
    end

    def access_token
      connected? ? cookie['access_token'] : nil
    end

    def user
      if connected?
        FbRails::Config.user_class.find_or_initialize_by_fb_uid(uid)
      end
    end
    memoize :user
  end
end
  