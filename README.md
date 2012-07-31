# Oath assist

Assists in setting up Rails 3 project with Oath and multiple service providers

Based on this tutorial: http://www.communityguides.eu/articles/16

I was however unsatisfied with the code structure (too much bloat) and wanted to extract the most crucial parts into some library code (gem) that is more extensible and customizable.

## Usage

`gem 'oath_assist'`

## Controller setup

Override included methods as necessary...

```ruby
class ServicesController < ApplicationController
  include OauthAssist::Controller
end
```

### Customize flash messages

Simply override the #msg method to create a different `MsgHandler` class or override any of the methods directly in the `MsgHandler` class.

Here we demonstrate explicitly including the main two controller helper modules.
Note: You can include a custom AuthHelper with custom functionality.

```ruby
class ServicesController < ApplicationController
  include OauthAssist::Controller::Services
  include OauthAssist::AuthHelper

  def msg
    @msghandler ||= MyLocalizedMsgHandler.new(flash)
  end
end
```

## Custom OAuth Data extraction

You can register custom OAuth Data extractors via:

```ruby
OauthAssist::Data::Extractor#register_extractor MyOwnParticularOauthStrategyExtractor
```

See the current Extractor code to see how to do this.

## Storing and loading Provider data

You can use the oatuh_providers generator to generate yml files for oauth service provider data. The generated files are `providers.yml` and `openid_providers.yml`, which are both places under `config/oauth`

Edit these files to insert you particular keys/ids and secrets for each service.
Note that the yml keys used for key/id and secret values are not important.

## Loading Provider data into the Omniauth middleware

This gem provides an extension to the OmniAuth builder in order to facilitate loading data for multiple providers from a hash.

To load the provider data, simply:

```ruby
OauthAssist::Provider::Builder.create_default.configure_providers
```

This will load in the provider data from the files generated via the generator (see above). You can load data from other sources by not using the #create_default factory method and instead explicitly creating an instance of the Builder with the provider hashes.

```ruby
provider_builder = OauthAssist::Provider::Builder.new my_providers
provider_builder.configure_providers
```

## Important notice

This gem has not yet been thoroughly tested. Please help out by trying it out and patching it where necessary... Thanks!

## Contributing to oath_assist
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Kristian Mandrup. See LICENSE.txt for
further details.

