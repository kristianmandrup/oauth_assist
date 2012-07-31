module OauthAssist
  module Data
    class Extractor
      def initialize service
        @service = service
      end

      def extract_from omniauth
        self.class.extractors.each do |extractor|
          return extractor.new(omniauth).extract if extractor.applies_to? service
        end
        nil # service_not_supported!    
      end

      class << self
        attr_accessor :extractors

        def extractors
          @extractors ||= default_extractors
        end

        def register_extractor clazz
          extractors << clazz
        end

        def default_extractors
          @default_extractors ||= %w{facebook github standard}.map {|name| "OauthAssist::Data::Extractor::#{name.camelize.constantize}" }
        end
      end

      def service_not_supported!
        raise %Q{Service #{service} is currently not supported by the OauthAssist::Data::Extractor. 
Please register an extractor class using the OauthAssist::Data::Extractor#register_extractor class method}
      end

      class Base
        attr_accessor :auth_hash, :omniauth

        def initialize omniauth
          @omniauth = omniauth
        end

        def auth_hash
          @auth_hash ||= {email: '', name: '', uid: '', provider: ''}
        end

        def extract
          authhash[:provider] = omniauth['provider'] if omniauth['provider']
          user_data_fields.each do |field|
            authhash[field] = user_data_entry[field.to_s] if user_data_entry[field.to_s]
          end
          authhash 
        end

        protected

        def user_data_fields
          [:email, :name, :uid]
        end
      end

      class Facebook < Base
        def initialize omniauth
          super
        end

        def self.applies_to? service
          service == 'facebook'
        end

        def extract
          super
        end      

        protected

        def user_data_entry
          info_entry
        end    

        def info_entry
          omniauth['extra']['raw_info']
        end
      end

      class Github < Base
        def initialize omniauth
          super
        end

        def self.applies_to? service
          service == 'github'
        end

        def id_value
          info_entry['id']
        end

        def extract
          super
          authhash[:uid] = id_value if id_value
        end      

        protected

        def user_data_fields
          [:email, :name]
        end

        def user_data_entry
          omniauth['info']['user_hash']
        end    
      end

      class Standard < Base
        def initialize omniauth
          super
        end

        def self.applies_to? service
          services_supported.include?(service)
        end

        def extract
          super
          authhash[:uid] = id_value if id_value
        end      

        def services_supported
          %w{google yahoo twitter myopenid open_id'}
        end

        protected

        def id_value
          omniauth['uid']
        end

        def user_data_fields
          [:email, :name]
        end

        def info_entry
          omniauth['info']
        end
      end
    end
  end
end