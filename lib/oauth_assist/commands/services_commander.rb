class ServicesCommander < Controll::Commander
  # register commands with controller
  commands :cancel_commit, :create_account, :signout

  def sign_in_command
    @sign_in_command ||= SignInCommand.new auth_hash: auth_hash, user_id: user_id, service_id: service_id, service_hash: service_hash, initiator: self
  end

  controller_methods :auth_hash, :user_id, :service_id, :service_hash
end