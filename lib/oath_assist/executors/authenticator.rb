require 'oauth_assist/executors/executor'

class Authenticator < Executor
  def execute
    valid? ? valid_auth.execute : invalid_auth.execute
    notifications.last || :success # return last notification as result
  end

  protected

  def valid?
    omniauth and params[:service]
  end  

  def invalid_auth
    InvalidAuth.new(controller)
  end

  def valid_auth
    ValidAuth.new(controller)
  end

  class InValidAuth < Executor
    def execute      
      notify :error
    end
  end

  class Success < Executor
    def execute
      # debug to output the hash that has been returned when adding new services
      notify :error and return unless auth_hash
      notify :auth_invalid and return unless auth_valid?
      signin_command.perform
    end

    # Use Imperator! Refactor module methods into Commands!
    def signin_command
      SignInCommand.new auth: auth, auth_hash: auth_hash, user_id: user_id, service_id: service_id, service_hash: service_hash
    end
  end
end