require 'oath_assist/extensions/omniauth_builder'

module OauthAssist
  module Provider
    class Builder
      attr_reader :providers, :openid_providers

      # the providers and openid_providers hashes can be loaded fx via 
      def initialize providers, openid_providers = {}
        @providers = providers unless providers.blank?
        @openid_providers = openid_providers unless openid_providers.blank?
      end

      def self.create_default
        self.new loader.providers, loader.openid_providers
      end

      def self.loader
        OauthAssist::Provider::Loader.instance
      end

      def configure_providers
        Rails.application.config.middleware.use OmniAuth::Builder do
          configure_providers providers if providers
          configure_openid_providers openid_providers if openid_providers
        end
      end
    end
  end
end