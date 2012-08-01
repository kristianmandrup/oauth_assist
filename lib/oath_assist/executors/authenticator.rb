require 'oauth_assist/executors/executor'

class Authenticator < Executor
  def execute
    valid_auth_params? ? valid_auth.execute : invalid_auth.execute
  end

  def invalid_auth
    InvalidAuth.new(controller)
  end

  def valid_auth
    ValidAuth.new(controller)
  end

  class InValidAuth < Executor
    def execute      
      :error
    end
  end

  class Success < Executor
    def execute
      # debug to output the hash that has been returned when adding new services
      return false if !authhash    
      auth_valid? ? signin_command.perform : signin_error_command.perform                
    end

    # Use Imperator! Refactor module methods into Commands!
    def signin_command
      SignInCommand.new auth
    end

    def signin_error_command 
      SignInErrorCommand.new auth
    end
  end
end