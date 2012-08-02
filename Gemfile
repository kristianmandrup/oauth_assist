source :rubygems

# to load provider data from yml files
gem 'rails_config_loader',  '~> 0.1.2'

gem 'controll',   path: '/Users/kmandrup/private/repos/controll' # :git => 'git@github.com:kristianmandrup/controll.git'
gem 'imperator',  path: '/Users/kmandrup/private/repos/imperator' # :git => 'git@github.com:kristianmandrup/imperator.git'
gem 'focused_controller'

group :test do
  gem 'database_cleaner', '~> 0.7'
  gem 'mongoid',          '~> 3'
  gem 'capybara',         '~> 1.1'
end

group :development do
  gem "rdoc",     ">= 3.12"
  gem "bundler",  ">= 1.1.0"
  gem "jeweler",  ">= 1.8.4"
  gem "simplecov",">= 0.5"
end

group :development, :test do
  gem "rspec",    ">= 2.11.0"
end

