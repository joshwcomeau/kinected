source 'https://rubygems.org'

# Default Rails gems
gem 'rails', '4.1.2'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',         group: :doc
gem 'spring',                   group: :development

gem 'angularjs-rails'               # Simple Angular wrapper for Rails
gem 'annotate'                      # Provides Schema-like annotations on the models' rb files.
gem 'cancancan', '~> 1.9'           # User authorization, controlling who can do what.
gem 'devise'                        # User authentication.
gem 'firebase_token_generator'      # Creates firebase token
gem 'font-awesome-rails'            # Custom icon pack.
gem 'geocoder'                      # Gets latitude and longitude from postal codes.
gem 'neat'                          # Bourbon grid system. Installs bourbon gem as well, as a dependency.
gem 'puma'                          # App server. Use this instead of WEBrick.
gem 'quiet_assets'                  # Hides asset stuff from the console.
gem 'rmagick', require: 'RMagick'   # Image processing for resizing and conversion and such.
gem 'ruby-units'                    # IGNORE THE DEPRECATION WARNING ON BUNDLE. I'm just using it to convert cm to ft/in
gem 'underscore-rails'              # Simple wrapper for the Underscore JS library.

gem 'carrierwave', github: 'carrierwaveuploader/carrierwave', ref: 'c2ee2e8'                   # File and image processing and storing, wraps rmagick.
gem 'carrierwave-processing'        # Adds quality, strip, colorspace and blur to carrierwave

group :development, :test do 
  gem 'factory_girl_rails'          # Provides factories for quick creation during tests.
  gem 'faker'                       # Provides quick data for seeds and tests
  gem 'pry'                         # Alternative console, allows for JS-style breakpoints.
  gem 'pry-byebug'                  # A Pry augmentor, provides convenience methods like 'next'.
  gem 'rspec-rails'                 # Testing framework. Better than what's included with Rails.
end 

group :test do 
  gem 'capybara'                    # Used for feature (browser-based) tests.
  gem 'capybara-webkit'             # Allows feature tests to run in a headless webkit state. Faster, but you can't see the magic.
  gem 'capybara-angular'            # Allows feature tests to work with Angular
  gem 'database_cleaner'            # Wipes the database between tests.
  gem 'guard-rspec'                 # Watches files for automated test running.
  gem 'launchy'                     # Launches a browser to show the state of a feature test. Useful for debugging
  gem 'selenium-webdriver'          # Allows feature tests to run in the browser. Slower, but you can see the magic.
end

group :production do
  gem 'shelly-dependencies'         # Convenience gem that sets up dependencies or deploying to ShellyCloud
end