require 'oauth_assist/commands/session_command'

class CreateAccountCommand < SessionCommand
  action do
    sign_in_new_user and return if newuser.save!
    notify :account_error
  end

  protected

  def sign_in_new_user
    sign_in_command.perform
    notify :account_created
  end

  def sign_in_command
    @sign_in_command ||= SignInCommand.new user_id: newuser.id, service_id: newuser.services.first.id
  end

  def newuser
    @newuser ||= create_user
  end    

  def create_user
    user        = user_class.new
    user.name   = session[:authhash][:name]
    user.email  = session[:authhash][:email]

    user.services.build user_service_hash
    user
  end

  def user_service_hash
    {
      :provider => session[:authhash][:provider], 
      :uid      => session[:authhash][:uid], 
      :uname    => session[:authhash][:name], 
      :uemail   => session[:authhash][:email]
    }
  end

  def user_class
    User
  end  
end