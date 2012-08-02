require 'oauth_assist/message_handler/flash'

module MessageHandler
  class Typed < Flash
    def error
      @error ||= Error.new flash, options
    end

    def notice
      @notice ||= Notice.new flash, options
    end

    protected

    def signal msg, type = :notice
      flash[type] = msg
    end  
  end
end
