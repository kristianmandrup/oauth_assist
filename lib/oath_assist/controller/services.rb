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
      matching_service_account?(current_user_service.id) ? msg.cant_delete_current_account! : current_user_service.destroy    
      redirect_to services_path
    end

    # POST from signup view
    def newaccount
      cancel_commit and return if params[:commit] == "Cancel" ?
      create_account
    end  
    
    # Sign out current user
    def signout 
      signout_user if current_user
      redirect_to root_url
    end
    
    # callback: success
    # This handles signing in and adding an authentication service to existing accounts itself
    # It renders a separate view if there is a new user to create
    def create    
      # continue only if hash and parameter exist
      valid_auth_params? ? handle_auth : handle_auth_error
    end

    def create    
      case Authenticator.new(self).execute
      when :no_auth
        render :text => omniauth.to_yaml if 
      when :error, :invalid, :auth_error
        redirect_to signin_path
      when :signed_in_con, :signed_in_new_con
        redirect_to services_path
      when :signed_in_user
        redirect_to root_url
      when :signed_in_new_user
        render signup_services_path
      else
        redirect_to root_url
      end
    end
    
    # callback: failure
    def failure
      msg.auth_service_error!      
      redirect_to root_url
    end

    protected

    def msg
      @msg_handler ||= OauthAssist::MsgHandler.new flash
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

    def cancel_commit
      session[:authhash] = nil
      session.delete :authhash
      redirect_to root_url
    end    

    # get the service parameter from the Rails router
    def service_route
      @service_route ||= params[:service] || 'No service recognized (invalid callback)'
    end

    def valid_auth_params?
      omniauth and params[:service]
    end
  end
end