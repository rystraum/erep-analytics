source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'mysql2'
gem 'haml'
gem 'haml-rails'
gem 'bluecloth'
gem 'paperclip'
gem 'devise' # rails g devise:install
gem 'jquery-rails'
gem 'acts_as_commentable_with_threading' # set up: rails generate acts_as_commentable_with_threading_migration
gem 'rails_admin', '= 0.0.3' # rails g rails_admin:install
gem 'thin'
gem "spawn", :git => 'git://github.com/rfc2822/spawn'
gem 'nokogiri'
gem "twitter-bootstrap-rails" # set up: rails g bootstrap:install

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group 'development' do
  gem 'pry'
end

group :production do
  gem 'mysql'
end

