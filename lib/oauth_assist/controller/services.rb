require 'oauth_assist/message_handler/services'
require 'oauth_assist/flow_handler/create_service'

module OauthAssist::Controller
  module Services
    before_filter :authenticate_user!, :except => accessible_actions
    protect_from_forgery :except => :create

    # GET all authentication services assigned to the current user
    def index
      @services = current_user.services.order('provider asc')
    end

    # POST to remove an authentication service
    def destroy
      # remove an authentication service linked to the current user    
      matching_service_account?(current_user_service.id) ? notify(:cant_delete_current_account) : current_user_service.destroy    
      do_redirect services_path
    end

    # POST from signup view
    def newaccount
      cancel_commit and return if params[:commit] == "Cancel" ?
      create_account_command.perform
    end  
    
    # Sign out current user
    def signout 
      signout_command.perform if current_user
      redirect_to root_url
    end
    
    # callback: success
    # This handles signing in and adding an authentication service to existing accounts itself
    # It renders a separate view if there is a new user to create
    def create    
      FlowHandler::CreateService.new(self).execute
    end

    protected

    # see 'controll' gem
    include Controll::Helper

    def msg_handler
      @msg_handler ||= OauthAssist::MsgHandler::Services.new flash, msg_options
    end        

    # register commands with controller

    def cancel_commit_command
      @cancel_commit_command ||= CancelCommitCommand.new initiator: self
    end    

    def create_account_command
      @create_account_command ||= CreateAccountCommand.new
    end

    def signout_command
      @signout_command ||= SignoutCommand.new current_user
    end

    # Alternative define:
    # def msg_options
    #   {service_name: service_name, full_route: full_route, provider_name: provider_name}
    # end

    def msg_options
      [:service_name, :full_route, :provider_name]
    end

    # callback: failure
    def failure
      notify :auth_service_error
      do_redirect root_url
    end

    def accessible_actions
      [:create, :signin, :signup, :newaccount, :failure]
    end

    def matching_service_account? service_id 
      session[:service_id] == service_id
    end

    def current_user_service
      @current_user_service ||= current_user.services.find(params[:id])
    end

    # get the service parameter from the Rails router
    def service_route
      @service_route ||= params[:service] || 'No service recognized (invalid callback)'
    end
  end
end