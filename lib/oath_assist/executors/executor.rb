class Executor
  attr_accessor :controller

  def initialize controller
    @controller = controller
  end

  def method_missing *args
    # send to controller
  end
end
