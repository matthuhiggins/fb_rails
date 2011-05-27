module FbRails
  class Railtie < Rails::Engine
    config.facebook = ActiveSupport::OrderedOptions.new

    initializer "fb_rails.set_configs" do |app|
      ActiveSupport.on_load :action_controller do
        app.config.facebook.each do |k,v|
          ::FbRails::Config.send "#{k}=", v
        end
      end
    end

    initializer "fb_rails.integration" do
      ActiveSupport.on_load :action_controller do
        include ::FbRails::Integration::ActionController
      end

      ActiveSupport.on_load :action_view do
        include ::FbRails::Integration::ActionView
      end
    end
  end
end