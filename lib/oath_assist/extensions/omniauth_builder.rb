module OmniAuth
  class Builder < ::Rack::Builder
    # provider: {key: 'fsdssdg', secret: 'dgdsgdg'}, provider: {client_id: 'fsdssdg', client_secret: 'dgdsgdg'}, ...
    # {facebook: {key: 'fsdssdg', secret: 'dgdsgdg'} }
    def configure_providers provider_hash = {}
      context = self
      provider_hash.each do |name, hash|
        context.provider name, *hash.values
      end
    end

    def configure_openid_providers provider_hash = {}
      # generic openid
      provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'openid'      
      
      context = self
      provider_hash.each do |name, identifier|
        context.provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => name.to_s, :identifier => identifier
      end
    end
  end
end