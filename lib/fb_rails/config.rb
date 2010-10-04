module FbRails
  class Config
    class_attribute :app_id, :secret, :user_class_name

    class << self
      def user_class
        (user_class_name || 'User').constantize
      end
    end
  end
end
