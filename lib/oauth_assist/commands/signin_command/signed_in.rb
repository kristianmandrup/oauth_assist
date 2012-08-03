require 'oauth_assist/commands/base'

class SignInCommand < Imperator::Command
  class SignedIn < Base
    def execute
      auth ? user_signed_in_and_connected : user_signed_in_connect_new
    end

    protected

    delegate :provider, :uid, to: :initiator

    def user_signed_in_and_connected
      notify :already_connected
      notify :user_signed_in_and_connected
    end

    def user_signed_in_connect_new
      current_user.services.create! service_hash

      notify :account_added
      notify :user_signed_in_connect_new
    end      
  end
end  