module Executor
  class Authenticator < Base
    def execute
      notify(:error) and return unless valid_params?
      notify(:auth_invalid) and return unless auth_valid?

      sign_in_command.perform
      result      
    end

    protected

    def result
      notifications.last || :success # return last notification as result
    end

    def valid_params?
      omniauth and service and auth_hash
    end  

    def sign_in_command
      SignInCommand.new auth: auth, auth_hash: auth_hash, user_id: user_id, service_id: service_id, service_hash: service_hash, executor: self
    end
  end
end