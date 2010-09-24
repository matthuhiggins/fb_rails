module FbRails
  class Config
    class_attribute :app_id, :secret
    DEFAULT_USER_MODEL = :User

    class << self
      def user_model=(model)
        @@user_model = model
      end

      def user_model
        @@user_model_klass ||= begin
          klass = (@@user_model || DEFAULT_USER_MODEL).to_s.classify.constantize
          klass.class_eval do
            attr_accessor :fb_access_token
          end
          klass
        end
      end
    end
  end
end
