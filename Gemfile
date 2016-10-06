source 'https://rubygems.org'

gem 'config', '1.3.0'
gem 'pg', '0.19.0'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'redis_rate_limiter', '0.0.9'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '2.9.2'
  gem 'ffaker', '2.2.0'
  gem 'rspec-rails', '~> 3.5.2'
end

group :production do
  gem 'heroku-deflater', '0.6.2'
  gem 'rails_12factor', '~> 0.0'
end
