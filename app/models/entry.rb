class Entry < ActiveRecord::Base
  resourcify
  belongs_to :yaopin
  belongs_to :user,:counter_cache=>true
  attr_accessible :changjia_name, :chengfen, :description, :guige, :name, :pihao, :tags_input, :title, :yongfa, :zhuzhi, :views
  validates_presence_of :title,:description
  scope :recent,order('id desc')
  scope :hot,order('views desc')
  def viewed
    increment! :views
  end
end
