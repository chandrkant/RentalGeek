# config/initializers/timeout.rb
# https://devcenter.heroku.com/articles/rails-unicorn#rack-timeout
Rack::Timeout.timeout = 10000  # seconds
