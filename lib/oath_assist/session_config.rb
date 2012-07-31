# use task: rake secret
module OauthAssist
  module Session
    def self.config options = {}
      app      = options[:app] || app_name
      domain   = options[:domain]
      expire   = options[:expire] || 1.month
      secure   = options[:secure] || false
      httponly = options[:http_only]
      httponly = true if httponly.nil?
      {
        :key          => "_omniauth_#{app}_session",        # name of cookie that stores the data
        :domain       => domain,                            # you can share between subdomains here: '.communityguides.eu'
        :expire_after => expire,                            # expire cookie
        :secure       => secure,                            # force https if true
        :httponly     => httponly,                          # a measure against XSS attacks, prevent client side scripts from accessing the cookie

        # you can also use Rails task: rake secret or the #random_secret method below
        :secret       => Rails.application.config.secret_token # see secret_token.rb initializer!
      }      
    end

    def self.app_name
      Rails.application.class.to_s.split("::").first
    end    

    def self.random_secret
      @random_secret ||= 128.times.inject("") {|res, n| res << (('a'..'z').to_a + (0..9).to_a.map(&:to_s)).sample }
    end
  end
end
