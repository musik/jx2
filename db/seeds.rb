# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
user = User.create! :name => 'muzik', :email => '58265826@qq.com', :password => 'angelayl', :password_confirmation => 'angelayl', :confirmed_at => Time.now.utc
puts 'New user created: ' << user.name
user.add_role :admin
