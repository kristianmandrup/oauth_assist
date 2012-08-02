require 'oauth_assist/commands/session_command'

class CreateAccountCommand < SessionCommand
  action do
    session[:authhash] = nil
    session.delete :authhash
    notify :commit_cancelled
  end   
end
