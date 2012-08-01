module OauthAssist
  module Controller
    extend ActiveSupport::Concern

    included do
      include OauthAssist::Controller::Services
      include OauthAssist::Controller::AuthHelper
    end
  end
end

require 'oauth_assist/controller/auth_helper'
require 'oauth_assist/controller/msg_handler'
require 'oauth_assist/controller/services_controller'

