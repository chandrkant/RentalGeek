source 'https://rubygems.org'

ruby '2.1.2'

gem 'rake', '>= 10.3.1'
gem 'rack-timeout' # https://devcenter.heroku.com/articles/rails-unicorn#rack-timeout
gem 'rails', '4.1.4'
gem 'pg'
gem 'braintree-rails', '~> 1.3.0'
gem 'uglifier'#, '>= 1.3.0'
gem 'psych', '>= 2.0.5'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'sprockets', '2.11.0' # https://stackoverflow.com/questions/22392862
gem 'mandrill-api', require: "mandrill"
gem 'pdfkit'
gem 'draper', '~> 1.3'
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
gem 'unicorn-rails' # Use unicorn as the app server
gem 'capistrano-rails', group: :development # Use Capistrano for deployment
gem 'capistrano-rvm', group: :development
gem 'devise'
gem 'devise-encryptable'
gem 'scrypt'
gem 'oj' # faster JSON rendering via MultiJSON
gem 'geocoder'
gem 'geonames_api'
gem 'geokit'
gem 'flag_shih_tzu'
gem "similar_text"
gem "paperclip", "~> 4.2"
gem 'fog'
gem 'newrelic_rpm'
# gem 'aws-s3'
#gem 'aws-sdk'

# http://devblog.agworld.com.au/post/42586025923/the-performance-of-to-json-in-rails-sucks-and-theres
gem 'rails-patch-json-encode'

gem 'validates_email_format_of'
gem 'validate_url'

gem 'date_validator'
gem 'roo'
gem "iconv", "~> 1.0.3"
gem 'rails_admin'

gem 'default_value_for'

gem 'active_model_serializers'#, git: 'git@github.com:rails-api/active_model_serializers.git'
gem 'grape'
gem 'grape-active_model_serializers'

gem 'rack-cors', :require => 'rack/cors'
gem 'hashie_rails'
gem 'foreigner'

gem 'strip_attributes'
gem 'mechanize'

gem 'airbrake'

gem 'rails_12factor', group: :production
gem 'rest-client'
gem 'google_places'
gem 'delayed_job_active_record'  #process jobs in background
gem "daemons"
gem 'cancancan', '~> 1.9'
#gem 'pusher'
gem 'rightsignature'   # To intract with RightSignature API
gem 'crack' #xml parser
gem 'kaminari'   #For pagination

group :development, :test do
  gem 'rspec-rails'
#  gem 'debugger'
  gem 'factory_girl_rails'
  gem 'syntax' # for RSpec's HTML output
  gem 'ffaker' # may want dummy data in console
  gem 'database_cleaner'
  gem 'awesome_print'
  gem 'byebug'
end

group :development do
  gem "binding_of_caller"
  gem "better_errors"
  gem 'seed_dump'
 # gem 'capistrano3-unicorn', git: 'git@github.com:tablexi/capistrano3-unicorn.git'
  gem "bullet"
end

