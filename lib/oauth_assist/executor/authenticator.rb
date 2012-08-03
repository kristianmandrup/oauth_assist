module Executor
  class Authenticator < Notificator
    def execute
      error(:error) and return unless valid_params?
      error(:auth_invalid) and return unless auth_valid?

      command! :sign_in
      result      
    end

    protected

    def auth_valid?
      uid != '' and provider != ''
    end

    def valid_params?
      omniauth and service and auth_hash
    end
  end
end