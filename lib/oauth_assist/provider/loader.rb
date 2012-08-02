module OauthAssist
  module Provider
    class Loader
      include Singleton
      include ConfigLoader::Delegator

      # load seed file (see geo-autocomplete demo)
      def providers
        @providers ||= load_hash 'config/providers.yml'
      end

      def openid_providers
        @openid_providers ||= load_hash 'config/openid_providers.yml'
      end
    end
  end
end