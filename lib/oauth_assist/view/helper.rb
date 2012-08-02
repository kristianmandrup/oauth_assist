module OauthAssist
  module View
    module Helper
      def services_enabled
        %w{aol facebook github google openid twitter yahoo}
      end

      def service_enabled? service
        services_enabled.include? service.to_s
      end

      def http_service? service
        service.uid.starts_with?('http')
      end

      def display_service_adr service
        http_service?(service) ? service.uid.scan(/http[s]*:\/\/.*?\//)[0] : "#{service.provider.capitalize} : #{service.uid}"
      end

      def service_provider service
        service_enabled?(service.provider) ? service.provider : 'openid'
      end

      def service_image service       
        image_tag "#{service_provider}_64.png", :size => "64x64"
      end

      def display_service_value name = :uname
        value = service.send(name)
        "#{value}<br/>".html_safe unless value.blank?
      end

      def remove_service_link service
        link_to "Remove this service", service, :confirm => t('oauth.remove_auth_confirm'), :method => :delete, :class => "remove"
      end
    end
  end