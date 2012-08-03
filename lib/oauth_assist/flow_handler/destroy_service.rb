module FlowHandler
  class DestroyService < Control
    protected

    def event
      command! :delete_service
      do_redirect services_path
    end
  end
end
