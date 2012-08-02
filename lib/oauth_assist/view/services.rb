module OauthAssist
  module View
    module Services
      def services_list *services
        options = extract_options! services
        content_tag :ul, :id => 'services_list' do
          services.flatten.compact.each do |service|
            service_item service, options[:type] || :simple
          end
        end
      end

      def service_item service, type = :simple
        send "#{type}_service_item", service
      end

      protected

      def simple_service_item service
        content_tag :li do
          link_to service.to_s.camelize, "/auth/#{service}"
        end
      end

      def icon_service_item service, icon_size = 64
        name = service.to_s.camelize
        content_tag :li do
          link_to "/auth/#{service}" do 
            image_tag "#{service}_#{icon_size}.png", :size => "#{icon_size}x#{icon_size}", :alt => name do
              name
            end
          end
        end
      end
    end
  end
end