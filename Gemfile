source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.7'

gem 'rails', '~> 5.2.3'
gem 'pg', "~> 1.0"
gem 'puma', '~> 3.11'
gem 'redis', '~> 4.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'sidekiq'
gem 'uglifier'
gem 'httparty'
gem 'webpacker'
gem 'react-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop', '~> 0.76.0', require: false
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "pry-rails",   "~> 0.3"
end

group :test do
  gem "database_cleaner", "~> 1.7"
end

group :development, :test do
  gem "rspec-rails", "~> 3.8"
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
