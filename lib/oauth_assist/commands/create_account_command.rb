require 'oauth_assist/commands/session_command'

class CreateAccountCommand < SessionCommand
  action do
    sign_in_new_user and return if newuser.save!
    error :account_error
  end

  protected

  hash_access_methods :authhash, hash: :session
  hash_access_methods :name, :email, :provider, :uid, hash: :authhash

  def sign_in_new_user
    command! :sign_in
    notify :account_created
  end

  def newuser
    @newuser ||= create_user
  end    

  def create_user
    user        = User.new
    user.name   = name
    user.email  = email

    user.services.build user_service_hash
    user
  end

  def user_service_hash
    {
      :provider => provider, 
      :uid      => uid, 
      :uname    => name, 
      :uemail   => email
    }
  end
end