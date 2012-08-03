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
      @event ||= authentication
    end

    def authentication
      @authentication ||= Authenticator.new(controller).execute
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
      def self.redirections
        {          
          signup_services_path: :signed_in_new_user
          services_path:        [:signed_in_connect, :signed_in_new_connect]
          root_url:             [:signed_in_user, :other]
        }
      end

      def self.error_redirections
        {
          signin_path:          [:error, :invalid, :auth_error]
        }
      end
    end
  end
end