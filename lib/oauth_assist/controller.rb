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

      # TODO: move to `controll` gem for reuse!
      commands.each {|command| command_method command}
    end
  end
end



