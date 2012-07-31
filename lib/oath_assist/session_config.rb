# use task: rake secret
module OauthAssist
  module Session
    def self.config options = {}
      app_name = options[:app_name]
      domain   = options[:domain]
      expire   = options[:expire] || 1.month
      secure   = options[:secure] || false
      httponly = options[:http_only]
      httponly = true if httponly.nil?
      {
        :key          => "_omniauth_#{app_name}_session",   # name of cookie that stores the data
        :domain       => domain,                            # you can share between subdomains here: '.communityguides.eu'
        :expire_after => expire,                            # expire cookie
        :secure       => secure,                            # force https if true
        :httponly     => true,                              # a measure against XSS attacks, prevent client side scripts from accessing the cookie

        # use Rails task: rake secret
        :secret       => 'cb8e1ac9dd5f4d08974f9f4d74abb45239a98b6cc3c59829ce6b61280160c421b4c18b0a721c26e0b4f43c1195875902...'
      }      
    end
  end
end
