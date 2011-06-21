module FbRails
  module TestHelper
    def fb_cookie(uid = 42, access_token = 'abc')
      value = FbRails::Cookie.encode({uid: uid, access_token: access_token}, FbRails::Config.secret)
      {FbRails::Connect.cookie_name => value}
    end
  end
end