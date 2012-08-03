class SignInCommand < Imperator::Command
  class Base < Executor
    def auth
      @auth ||= Service.where(provider: provider, uid: uid).first
    end
  end
end    