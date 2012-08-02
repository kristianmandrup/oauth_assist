require 'oauth_assist/message_handler/flash'

module MessageHandler
  class Notify < Flash
    def notify name, options = {}
      self.options.merge! options
      send(name)
    end
  end
end
