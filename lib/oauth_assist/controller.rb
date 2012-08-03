require 'oauth_assist/controller/services'
require 'oauth_assist/controller/auth_helper'
require 'oauth_assist/controller/user_helper'

module OauthAssist
  module Controller
    extend ActiveSupport::Concern

    included do
      include OauthAssist::Controller::Services
      include OauthAssist::Controller::AuthHelper
      include OauthAssist::Controller::UserHelper
    end
  end
end

class ApplicationController
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end
  
  def user_signed_in?
    !current_user.nil?
  end
end  



