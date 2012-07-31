module OauthAssist
  module Rails
    class Engine < ::Rails::Engine        
      initializer "setup for rails" do
        ActionView::Base.send :include, OauthAssist::View::Services
        ActionView::Base.send :include, OauthAssist::View::Session
      end
    end
  end
end
