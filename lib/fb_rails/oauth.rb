require 'digest/md5'

module FbRails
  class Oauth
    class << self
      def parse_cookie(cookie_string, secret)
        return if cookie_string.blank?
        cookie_string = Rack::Utils.unescape(cookie_string)

        hash = Rack::Utils.parse_query(cookie_string.gsub(/^\"|\"$/, ''))

        payload = ''
        hash.sort.each do |key, value|
          payload += "#{key}=#{value}" if key != 'sig'
        end

        md5 = Digest::MD5.hexdigest("#{payload}#{secret}")
        if md5 == hash['sig']
          hash
        end
      end

      def create_cookie(attributes, secret)
        sorted_pairs = attributes.sort.map { |key, value| "#{key}=#{value}" }
        param_string = sorted_pairs.join('&')
        payload = sorted_pairs.join('')
        sig = Digest::MD5.hexdigest("#{payload}#{secret}")
        "\"#{param_string}&sig=#{sig}\""
      end
    end
  end
end