module FbRails
  module TestHelper
    # Creates a hash representation of the facebook cookie.
    # To use this in tests, you might do the following:
    # 
    #   class MyControllerTest < ActionController::TestCase
    #     test 'request that requires authentication' do
    #       @request.cookies.merge! fb_cookie
    #       get :protected_action
    #     end
    #   end
    # 
    def fb_cookie(uid = 42, access_token = 'abc')
      value = FbRails::Cookie.encode({uid: uid, access_token: access_token}, FbRails::Config.secret)
      {FbRails::Connect.cookie_name => value}
    end
  end
end