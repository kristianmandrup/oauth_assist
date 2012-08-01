Authenticator < Executor
  def initialize controller
  end

  def execute
    valid_auth_params? ? error.execute : success.execute
  end

  def error
    Error.new(controller)
  end

  def success
    Success.new(controller)
  end

  class Error < Executor
    def execute
      msg.auth_error! service_name
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