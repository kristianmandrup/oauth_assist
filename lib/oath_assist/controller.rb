module OauthAssist
  module Controller
    extend ActiveSupport::Concern

    included do
      include OauthAssist::Controller::Services
      include OauthAssist::Controller::AuthHelper
    end
  end
end

require 'oath_assist/controller/auth_helper'
require 'oath_assist/controller/msg_handler'
require 'oath_assist/controller/services_controller'

