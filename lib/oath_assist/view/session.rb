module OauthAssist
  module View
    module Session
      def nav_user_signin *services
        content_tag :ul do
          content_tag(:span, t('sign_in')) +
          services_list services, :simple
        end
      end

      def nav_user_signed_in
        content_tag :ul do
          content_tag(:span, current_user.email) +
          content_tag(:li, link_to( t('oauth.services.settings'), services_path)) +
          content_tag(:li, link_to( t('session.signout'), signout_services_path))          
        end
      end
    end
  end
end