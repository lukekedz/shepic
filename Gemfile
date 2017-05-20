source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# additional gems
gem 'devise'
gem 'simple_form'
gem 'materialize-sass'
gem 'hirb'
gem 'auto_increment'

gem 'faker'

# exporting
gem 'axlsx_rails'

# solving problem after brew install postgresql, when trying to restore copy of Heroku db
# tried bew link readline --force, but still had errors when launching rails c
gem 'rb-readline'

group :development, :test do
	gem 'spring'
	gem 'dotenv-rails'
	gem 'rspec-rails', '~> 3.5'
	gem 'simplecov', :require => false, :group => :test
end

group :production do
	gem 'rails_12factor'
end



