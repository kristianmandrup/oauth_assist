module OauthAssist::Controller
  module UserHelper
    def current_user  
      @current_user ||= User.find(session[:user_id]) if session[:user_id]  
    end
    
    def user_signed_in?
      !current_user.nil?
    end
      
    def authenticate_user!
      if !current_user
        msg.must_sign_in!
        redirect_to signin_services_path
      end
    end 
  end
end
