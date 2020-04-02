source 'https://rubygems.org'

gem 'rails', '~> 5.2.0'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'nokogiri'
gem 'active_model_serializers'
gem 'rack-cors'
gem 'knnball'
gem 'swissgrid'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'awesome_print'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano', '~> 3.11.0'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano3-puma'
end

group :test do
  gem 'webmock'
end

group :production do
  gem 'rails_12factor'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby '2.5.1' # for heroku
