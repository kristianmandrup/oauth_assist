require 'oauth_assist/commands/base'

class SignInCommand < Imperator::Command
  class SignedOut < Base
    def execute
      auth ? sign_in_existing_user : sign_in_new_user
    end

    def sign_in_existing_user
      # signin existing user
      # in the session his user id and the service id used for signing in is stored
      session[:user_id]     = user_id
      session[:service_id]  = service_id
    
      notify :signed_in_existing_user      
    end

    def sign_in_new_user
      # this is a new user; show signup; @authhash is available to the view and stored in the sesssion for creation of a new user
      session[:authhash] = auth_hash
      notify :signed_in_new_user
    end    
  end
end