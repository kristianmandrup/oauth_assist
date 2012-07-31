# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "oath_assist"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = "2012-07-31"
  s.description = "Based on the code in http://www.communityguides.eu/articles/16 but heavily refactored"
  s.email = "kmandrup@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "app/views/signup.html.erb",
    "app/views/signup.html.haml",
    "config/oauth_assist_en.yml",
    "lib/generators/oauth_providers_generator.rb",
    "lib/generators/templates/openid_providers.yml",
    "lib/generators/templates/providers.yml",
    "lib/oath_assist.rb",
    "lib/oath_assist/controller.rb",
    "lib/oath_assist/controller/account_helper.rb",
    "lib/oath_assist/controller/auth_helper.rb",
    "lib/oath_assist/controller/msg_handler.rb",
    "lib/oath_assist/controller/services.rb",
    "lib/oath_assist/controller/user_helper.rb",
    "lib/oath_assist/controller/user_session_helper.rb",
    "lib/oath_assist/data/extractor.rb",
    "lib/oath_assist/engine.rb",
    "lib/oath_assist/extensions/omniauth_builder.rb",
    "lib/oath_assist/provider.rb",
    "lib/oath_assist/provider/builder.rb",
    "lib/oath_assist/provider/loader.rb",
    "lib/oath_assist/session_config.rb",
    "lib/oath_assist/view.rb",
    "lib/oath_assist/view/services.rb",
    "lib/oath_assist/view/session.rb",
    "spec/oath_assist_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/kristianmandrup/oath_assist"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Helper modules for setting up Oauth in Rails 3 with Users having multiple Oauth service providers"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails_config_loader>, ["~> 0.1.2"])
      s.add_development_dependency(%q<rspec>, [">= 2.8.0"])
      s.add_development_dependency(%q<rdoc>, [">= 3.12"])
      s.add_development_dependency(%q<bundler>, [">= 1.1.0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.8.4"])
      s.add_development_dependency(%q<simplecov>, [">= 0.5"])
    else
      s.add_dependency(%q<rails_config_loader>, ["~> 0.1.2"])
      s.add_dependency(%q<rspec>, [">= 2.8.0"])
      s.add_dependency(%q<rdoc>, [">= 3.12"])
      s.add_dependency(%q<bundler>, [">= 1.1.0"])
      s.add_dependency(%q<jeweler>, [">= 1.8.4"])
      s.add_dependency(%q<simplecov>, [">= 0.5"])
    end
  else
    s.add_dependency(%q<rails_config_loader>, ["~> 0.1.2"])
    s.add_dependency(%q<rspec>, [">= 2.8.0"])
    s.add_dependency(%q<rdoc>, [">= 3.12"])
    s.add_dependency(%q<bundler>, [">= 1.1.0"])
    s.add_dependency(%q<jeweler>, [">= 1.8.4"])
    s.add_dependency(%q<simplecov>, [">= 0.5"])
  end
end
