module FbRails
  class Config
    class_attribute :app_id, :secret
    DEFAULT_USER_MODEL = :User

    class << self
      def user_class=(model)
        @@user_class = model
      end

      def user_class
        @@user_class_klass ||= begin
          klass = (@@user_class || DEFAULT_USER_MODEL).to_s.classify.constantize
          klass.class_eval do
            attr_accessor :fb_access_token
          end
          klass
        end
      end
    end
  end
end
