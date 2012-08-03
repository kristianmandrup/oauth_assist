require 'oauth_assist/message_handler/services'
require 'oauth_assist/flow_handler/create_service'

module OauthAssist::Controller
  module Services
    class Action < OauthAssist::BaseAction
      before_filter :authenticate_user!, :except => [:create, :signin, :signup, :newaccount, :failure]
      protect_from_forgery :except => :create

      protected

      # see 'controll' gem
      include Controll::Helper
      include OauthAssist::Controller::ParamsHelper

      message_handler :services
      commander :services      

      # TODO use flow_handler
      def authenticate_user!
        unless current_user
          do_redirect :must_sign_in # makes a notice and redirects using map below
        end
      end

      redirect_map signin_services_path: :must_signin
    end

    # GET all authentication services assigned to the current user
    class Index < Action
      # TODO: use expose

      run do
        @services = service_list
      end

      protected

      def service_list
        current_user.services.order('provider asc')
      end
    end

    # POST to remove an authentication service
    class Destroy < Action
      run do
        # remove an authentication service linked to the current user    
        use_command(:delete_service).redirect
      end

      protected

      redirect_map services_path: [:success, :cant_delete_current_account]

      def current_user_service
        @current_user_service ||= current_user.services.find(params[:id])
      end

      def matching_service_account? service_id 
        session[:service_id] == service_id
      end      
    end

    # POST from signup view
    class NewAccount < Action
      run do
        use_command command_name
      end

      protected

      def command_name
        commit_cancelled? ? :cancel_commit : :create_account
      end

      def commit_cancelled?
        params[:commit] == "Cancel"
      end      
    end  
    
    # Sign out current user
    class Signout < Action
      run do
        command! :signout if current_user
        do_redirect root_url
      end
    end
    
    # callback: success
    # This handles signing in and adding an authentication service to existing accounts itself
    # It renders a separate view if there is a new user to create
    class Create < Action
      run do
        flow_handler.execute
      end

      protected

      flow_handler :create_service

      def auth
        @auth ||= Service.where(provider: provider, uid: uid).first
      end
    end

    protected

    # callback: failure
    class Failure < Action
      run do
        error(:auth_service_error).do_redirect root_url         
      end
    end
  end
end