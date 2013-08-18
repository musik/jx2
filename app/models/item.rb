class Item < ActiveRecord::Base
  belongs_to :yaopin
  attr_accessible :price, :scope, :title, :url
end
