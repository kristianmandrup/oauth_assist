require 'oauth_assist/commands/session_command'

class DeleteServiceCommand < SessionCommand
  action do
    # remove an authentication service linked to the current user    
    delete? ? current_user_service.destroy : notify(:cant_delete_current_account)
  end

  protected

  def delete?
    !matching_service_account?(current_user_service.id)
  end
end
