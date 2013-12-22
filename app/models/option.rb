class Option < ActiveRecord::Base
  attr_accessible :autoload, :data, :name
  def self.get key
    vals[key.to_s]
  end
  def self.html key
    vals[key.to_s].html_safe
  end
  def self.vals
     Hash[where(autoload: true).all.collect{|r|
      [r.name,r.data]
     }]
  end
end
