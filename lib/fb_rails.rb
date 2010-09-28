module FbRails
  extend ActiveSupport::Autoload

  autoload :Config
  autoload :Connect
  autoload :Graph
  autoload :Fb
  autoload :Mock
  autoload :Integration

  def self.cookie(uid = 42, access_token = 'abc')
    param_string = "uid=#{uid}&access_token=#{access_token}"
    payload = "access_token=#{access_token}uid=#{uid}"
    sig = Digest::MD5.hexdigest("#{payload}#{FbRails::Config.secret}")
    {FbRails::Connect.cookie_name => "\"#{param_string}&sig=#{sig}\""}
  end
end

require 'fb_rails/railtie'