class SignInCommand < Imperator::Command
  class SignedIn < Executor
    def initialize initiator
      @initiator = initiator
    end

    def execute
      auth ? user_signed_in_and_connected : user_signed_in_connect_new
    end

    protected

    delegate :provider, :uid, to: :initiator

    def auth
      @auth ||= service_class.where(provider: provider, uid: uid).first
    end

    def service_class
      Service
    end    

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