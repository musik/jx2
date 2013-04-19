class Entry < ActiveRecord::Base
  belongs_to :yaopin
  attr_accessible :changjia_name, :chengfen, :description, :guige, :name, :pihao, :tags_input, :title, :yongfa, :zhuzhi
  validates_presence_of :title,:description
end
