module FbRails
  class Connect
    class << self
      def cookie_name
        "fbs_#{FbRails::Config.app_id}"
      end
    end

    attr_reader :cookies
    def initialize(cookies)
      @cookies = cookies
    end

    def cookie
      @cookie ||= FbRails::Cookie.decode(cookies[self.class.cookie_name], FbRails::Config.secret)
    end

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
        @user ||= begin
          record = FbRails::Config.user_class.find_or_initialize_by_fb_uid(uid)
          record.access_token = access_token
          record
        end
      end
    end
  end
end
  