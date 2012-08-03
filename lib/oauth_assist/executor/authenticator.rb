module Executor
  class Authenticator < Notificator
    def execute
      error(:error) and return unless valid_params?
      error(:auth_invalid) and return unless auth_valid?

      sign_in_command.perform
      result      
    end

    protected

    def valid_params?
      omniauth and service and auth_hash
    end
  end
end