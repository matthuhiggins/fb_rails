module FbRails
  class Config
    class_attribute :app_id, :secret, :user_class_name, :timeout
    self.timeout = 60

    class << self
      def user_class
        klass = (user_class_name || 'User').constantize
        klass.class_eval do
          attr_accessor :access_token
        end unless klass.method_defined?(:access_token)
        klass
      end
    end
  end
end
