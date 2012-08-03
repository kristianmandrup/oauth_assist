module OauthAssist::Controller
  module ParamsHelper < Controll::ParamsHelper
    param_methods :service, :commit
    hash_access_methods :uid, :provider, hash: :auth_hash

    # get the service parameter from the Rails router
    def service_route
      @service_route ||= service || 'No service recognized (invalid callback)'
    end
        
    def auth_hash
      @auth_hash ||= data_extractor.extract_from omniauth
    end

      # get the full hash from omniauth
    def omniauth
      request.env['omniauth.auth']
    end    

    def data_extractor
      @data_extractor ||= OauthAssist::DataExtractor.new service_route
    end    
  end
end