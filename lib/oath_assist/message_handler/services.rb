require 'oauth_assist/message_handler/notify'
require 'oauth_assist/message_handler/typed'

module MessageHandler
  class Services < Typed
    class Error < MessageHandler::Notify
      def must_sign_in!
        signal 'You need to sign in before accessing this page!', :error
      end

      def auth_service_error!
        signal 'There was an error at the remote authentication service. You have not been signed in.', :error
      end

      def cant_delete_current_account!
        signal 'You are currently signed in with this account!', :error
      end

      def user_save_error
        signal 'This is embarrassing! There was an error while creating your account from which we were not able to recover.', :error
      end

      def auth_error!
        signal 'Error while authenticating via ' + service_name + '. The service did not return valid data.', :error

      def auth_invalid!
        signal 'Error while authenticating via ' + full_route + '. The service returned invalid data for the user id.', :error
      end
    end
    
    class Notice < MessageHandler::Notify
      def already_connected
        signal 'Your account at ' + provider_name + ' is already connected with this site.', :notice
      end

      def account_added!
        signal 'Your ' + provider_name + ' account has been added for signing in at this site.', :notice
      end

      def signed_in!
        signal 'Your account has been created and you have been signed in!', :notice
      end

      def sign_in_success!
        signal 'Signed in successfully via ' + provider_name + '.', :notice
      end

      def signed_out!
        signal 'You have been signed out!', :notice
      end
    end
  end
end