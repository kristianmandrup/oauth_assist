module FlowHandler
  class CreateService < Control
    protected

    def use_fallback
      event == :no_auth ? do_render(:text => omniauth.to_yaml) : fallback_action
    end      

    def action_handlers
      [Redirect, Render]
    end

    def event
      @event ||= Authenticator.new(controller).execute
    end

    class Render < FlowHandler::Render
      def self.default_path
        :signup_services_path
      end

      def self.events
        [:signed_in_new_user]
      end
    end

    class Redirect < FlowHandler::Render
      def self.redirect_map
        {
          signin_path:          [:error, :invalid, :auth_error]
          signup_services_path: :signed_in_new_user
          services_path:        [:signed_in_connect, :signed_in_new_connect]
          root_url:             [:signed_in_user, :other]
        }
      end
    end
  end
end