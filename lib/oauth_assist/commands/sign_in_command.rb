require 'oauth_assist/commands/session_command'

class SignInCommand < SessionCommand
  attributes :user_id, :service_id, String 

  # :provider => provider, :uid => uid, :uname => authhash[:name], :uemail => authhash[:email]
  attribute :service_hash, :auth_hash, Hash

  action do
    # if the user is currently signed in, he/she might want to add another account to signin
    user_signed_in? ? signed_in : signed_out
  end

  protected

  delegate :provider, :uid, to: :initiator

  def signed_in 
    @signed_in ||= SignedIn.new(self).perform
  end

  def signed_out
    @signed_out ||= SignedOut.new(self).perform
  end
end
