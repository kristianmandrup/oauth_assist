module OauthAssist::Controller
  module AccountHelper
    def create_account    
      newuser.save! ? sign_in_new_user! : user_save_error
      redirect_to root_url
    end

    def newuser
      @newuser ||= create_user
    end    

    protected

    def create_user
      user = user_class.new
      user.name = session[:authhash][:name]
      user.email = session[:authhash][:email]
      user.services.build(:provider => session[:authhash][:provider], :uid => session[:authhash][:uid], :uname => session[:authhash][:name], :uemail => session[:authhash][:email])
      user
    end

    def user_class
      User
    end
  end
end