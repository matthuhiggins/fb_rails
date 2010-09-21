module FbRails
  class Config
    class_attribute :app_id, :secret

    def user_model
      User
    end
  end
end
