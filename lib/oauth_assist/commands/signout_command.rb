require 'oauth_assist/commands/session_command'

class SignInCommand < SessionCommand
  action do
    session[:user_id] = nil
    session[:service_id] = nil
    session.delete :user_id
    session.delete :service_id

    notify :signed_out
  end   
end