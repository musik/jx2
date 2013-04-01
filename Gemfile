require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://ruby.taobao.org'
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
gem "guard", ">= 0.6.2", :group => :development  
case HOST_OS
  when /darwin/i
    gem 'rb-fsevent', :group => :development
    gem 'growl', :group => :development
  when /linux/i
    gem 'libnotify', :group => :development
    gem 'rb-inotify', :group => :development
  when /mswin|windows/i
    gem 'rb-fchange', :group => :development
    gem 'win32console', :group => :development
    gem 'rb-notifu', :group => :development
end
gem "guard-bundler", ">= 0.1.3", :group => :development
gem "guard-rails", ">= 0.0.3", :group => :development
gem "guard-livereload", ">= 0.3.0", :group => :development
gem "guard-rspec", ">= 0.4.3", :group => :development
gem "devise", ">= 2.1.0"
gem "cancan", ">= 1.6.7"
gem "rolify", ">= 3.1.0"
#gem "bootstrap-sass", ">= 2.0.3"
gem "bootstrap-sass", "~> 2.1.0.0"
gem "simple_form"
#gem "therubyracer", :group => :assets, :platform => :ruby

gem 'stringex'
gem 'breadcrumbs'
gem 'kaminari','0.13.0'
gem 'bootstrap-kaminari-views'

gem 'thin'
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
