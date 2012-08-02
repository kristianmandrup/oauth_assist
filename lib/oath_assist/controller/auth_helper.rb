require 'oauth_assist/controller/user_session_helper'

module OauthAssist::Controller
  module AuthHelper
    include OauthAssist::Controller::UserSessionHelper

    # map the returned hashes to our variables first - the hashes differs for every service
    def auth_hash 
      @auth_hash ||= extract_from omniauth
    end

    def data_extractor
      @data_extractor ||= OauthAssist::Data::Extractor.new service_route
    end

    def uid
      auth_hash[:uid]
    end

    def provider
      auth_hash[:provider]
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