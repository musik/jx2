require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
#source 'http://ruby.taobao.org'
source 'http://rubygems.org'
gem 'rails', '3.2.5'
gem 'mysql2'
gem 'execjs'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'
end
gem 'jquery-rails','2.1.3'
gem "haml", ">= 3.1.6"
gem "haml-rails", ">= 0.3.4", :group => :development
gem "rspec-rails", ">= 2.10.1", :group => [:development, :test]
gem "database_cleaner", ">= 0.8.0", :group => :test
# gem "mongoid-rspec", ">= 1.4.4", :group => :test
gem "factory_girl_rails", ">= 3.3.0", :group => [:development, :test]
gem "email_spec", ">= 1.2.1", :group => :test
gem "devise", ">= 2.1.0"
gem "cancan", ">= 1.6.7"
gem "rolify", ">= 3.1.0"
#gem "bootstrap-sass", ">= 2.0.3"
gem "bootstrap-sass", "~> 2.1.0.0"
gem "simple_form"
#gem "therubyracer", :group => :assets, :platform => :ruby

group :development do
  gem 'libnotify', :group => :development
  gem 'rb-inotify', :require => false
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'capistrano'
  #gem 'capistrano-ext'
  gem 'capistrano-recipes'
  gem 'capistrano-helpers'
  #gem 'rvm-capistrano'
  gem 'capistrano-unicorn',:git=>'git://github.com/sosedoff/capistrano-unicorn.git'
  gem 'capistrano-resque'
  gem 'thin'
end
gem 'stringex'
gem 'breadcrumbs'
gem 'kaminari','0.14.1'
gem 'bootstrap-kaminari-views'

gem 'typhoeus','0.3.3'
gem 'nokogiri'

gem "mocha", :group => :test

gem 'daemons'
gem 'delayed_job_active_record'
gem 'whenever', :require => false

gem 'simple_enum'
gem 'awesome_nested_set'

gem 'htmlentities' 
gem 'oauth'
gem 'oauth_china'

gem 'redis'
gem 'redis-rails'


gem 'thinking-sphinx', '2.0.13'
gem 'ts-datetime-delta', '1.0.3',:require => 'thinking_sphinx/deltas/datetime_delta'
gem 'resque'

gem 'rails_admin'
gem 'RedCloth'

gem 'unicorn'
#gem 'wicked_pdf'
gem 'prawn'
gem 'prawn_rails'
