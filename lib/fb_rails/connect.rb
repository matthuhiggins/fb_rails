module FbRails
  class Connect
    extend ActiveSupport::Memoizable

    attr_reader :cookie_string
    def initialize(cookies)
      @cookie_string = cookies[cookie_name]
    end

    def cookie
      return if cookie_string.blank?

      hash = Rack::Utils::parse_query(cookie_string.gsub(/^\"|\"$/, ''))
      sorted_pairs = hash.sort
  
      payload = ''
      sorted_pairs.each do |key, value|
        if key != 'sig'
          payload += "#{key}=#{value}"
        end
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
      cookie['uid']
    end

    def user
      if connected?
        @user ||= User.find_or_create_by_fb_uid(uid)
        @user.access_token = cookie['access_token']
        @user
      end
    end

    def cookie_name
      "fbs_#{FbRails::Config.app_id}"
    end
  end
end