class OAuthProvidersGenerator < Rails::Generator::Base
  desc 'Copies a basic providers.yml file to config/providers.yml'

  def main_flow
    template 'providers.yml', "config/oath/providers.yml"
    template 'openid_providers.yml', "config/oath/openid_providers.yml"
  end
end