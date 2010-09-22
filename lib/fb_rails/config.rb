module FbRails
  class Config
    class_attribute :app_id, :secret

    class << self
      def user_model=(model)
        model.class_eval do
          attr_accessor :fb_access_token
        end
        @@user_model = model
      end

      def user_model
        @@user_model ||= User
      end
    end
  end
end
