require 'oauth_assist/controller/account_helper'

module OauthAssist::Controller
  module UserSessionHelper
    include OauthAssist::Controller::AccountHelper

    def sign_in_new_user!
      # signin existing user
      # in the session his user id and the service id used for signing in is stored
      session[:user_id] = newuser.id
      session[:service_id] = newuser.services.first.id      
      msg.signed_in!
    end

    def signout_user
      session[:user_id] = nil
      session[:service_id] = nil
      session.delete :user_id
      session.delete :service_id
      signed_out!
    end    

    def user_signed_in
      auth ? user_signed_in_and_connected : user_signed_in_connect_new
    end

    def user_not_signed_in
      auth ? sign_in_existing_user : sign_in_new_user
    end

    def user_signed_in_and_connected
      msg.already_connected! provider_name
      redirect_to services_path
    end

    def user_signed_in_and_new_connection
      current_user.services.create!(:provider => provider, :uid => uid, :uname => authhash[:name], :uemail => authhash[:email])
      msg.account_added! provider_name
      redirect_to services_path
    end    

    def sign_in_existing_user
      # signin existing user
      # in the session his user id and the service id used for signing in is stored
      session[:user_id] = auth.user.id
      session[:service_id] = auth.id
    
      msg.sign_in_success! provider_name
      redirect_to root_url
    end

    def sign_in_new_user
      # this is a new user; show signup; @authhash is available to the view and stored in the sesssion for creation of a new user
      session[:authhash] = authhash
      render signup_services_path
    end
  end
end