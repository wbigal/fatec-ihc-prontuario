source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# JavaScript libraries and related
gem 'jquery-rails', '~> 4.3.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Bootstrap 4 Ruby Gem for Rails / Sprockets and Compass.
gem 'bootstrap', '~> 4.0.0.beta2.1'
# An email validator for Rails
gem 'email_validator'
# A Ruby static code analyzer, based on the community Ruby style guide.
gem 'rubocop', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  # RSpec for Rails-3+
  gem 'rspec-rails', '~> 3.6'
  # Factory Girl S2 Rails
  gem 'factory_bot_rails'
  # Loads environment variables from `.env`
  gem 'dotenv-rails'
  # A library for generating fake data such as names, addresses,
  #  and phone numbers.
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere
  # in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # A static analysis security vulnerability scanner for RoR applications
  gem 'brakeman', require: false
  # Annotate Rails classes with schema and routes info
  gem 'annotate'
end

group :test do
  # Code coverage for Ruby 1.9+ with a powerful configuration library and
  # automatic merging of coverage across test suites
  gem 'simplecov', require: false
  # Strategies for cleaning databases in Ruby.
  # Can be used to ensure a clean state for testing.
  gem 'database_cleaner'
  # Collection of testing matchers extracted from Shoulda
  gem 'shoulda-matchers', require: false
  # Brings back `assigns` and `assert_template` to your Rails tests
  gem 'rails-controller-testing'
  # CodeClimate Test Integration
  gem 'codeclimate-test-reporter', require: nil
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :production do
  gem 'rails_12factor'
end
