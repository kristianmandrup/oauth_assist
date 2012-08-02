module MessageHandler
  class Flash
    attr_accessor :flash, :options

    def initialize flash, options
      @flash = flash
      @options = options

      # create instance method for each msg option
      case options
      when Hash
        options.each do |key, value|
          self.class.define_method key do
            value
          end
        end
      when Array
        options.each do |meth|
          self.class.define_method meth do
            send(meth)
          end
        end
      end
    end
  end
end
