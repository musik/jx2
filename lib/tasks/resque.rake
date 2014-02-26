require 'resque/tasks'
require 'resque_scheduler/tasks'
require 'resque/pool/tasks'
namespace :resque do
  task :setup => :environment do
    ENV["QUEUE"] ||= '*'
    Resque.before_fork = Proc.new {
      ActiveRecord::Base.establish_connection 
      #Resque.redis.client.reconnect
    }
    Resque.schedule = YAML.load_file("#{Rails.root}/config/scheduler.yml")
  end
  task "pool:setup" do
    ActiveRecord::Base.connection.disconnect!
    Resque::Pool.after_prefork do |job|
      ActiveRecord::Base.establish_connection
      Resque.redis.client.reconnect
    end    
  end
  #task "pool:delta"=> %w[resque:setup resque:pool:setup] do
    #require 'resque/pool'
    #ENV['INTERVAL']='180'
    #Resque::Pool.new("config/resque-pool-delta.yml").start.join
  #end
end
