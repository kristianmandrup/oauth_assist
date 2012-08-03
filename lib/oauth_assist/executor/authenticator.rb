module Executor
  class Authenticator < Base
    def execute
      error(:error) and return unless valid_params?
      error(:auth_invalid) and return unless auth_valid?

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
  end
end