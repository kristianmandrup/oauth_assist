require 'oauth_assist/controller/user_session_helper'

module OauthAssist::Controller
  module AuthHelper
    include OauthAssist::Controller::UserSessionHelper

    def handle_auth
      # debug to output the hash that has been returned when adding new services
      render :text => omniauth.to_yaml and return if !authhash    
      auth_valid? ? handle_auth_token : handle_auth_invalid                
    end    

    # map the returned hashes to our variables first - the hashes differs for every service
    def authhash 
      @authhash ||= extract_from omniauth
    end

    def data_extractor
      @data_extractor ||= OauthAssist::Data::Extractor.new service_route
    end

    def uid
      authhash[:uid]
    end

    def provider
      authhash[:provider]
    end

    def provider_name
      provider.capitalize
    end

    def service_name
      service_route.capitalize
    end

    def full_route
      service_route + '/' + provider_name
    end

    def handle_auth_error
      msg.auth_error! service_name
      redirect_to signin_path
    end

    def handle_auth_token
      # if the user is currently signed in, he/she might want to add another account to signin
      user_signed_in? ? user_signed_in(auth) : user_not_signed_in(auth)
    end    

    def handle_auth_invalid
      msg.auth_invalid! full_route
      redirect_to signin_path
    end    

    def auth
      @auth ||= service_class.where(provider: provider, uid: uid).first
    end

    def service_class
      Service
    end

    def auth_valid?
      uid != '' and provider != ''
    end

      # get the full hash from omniauth
    def omniauth
      request.env['omniauth.auth']
    end
  end
end