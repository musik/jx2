class Post < ActiveRecord::Base
  attr_accessible :author, :content, :laiyuan, :laiyuan_url, :publish, :title,:seo_title,:excerpt,:keywords
  scope :recent,order("id desc")
  scope :published,where(:publish=>true)
  def description
    excerpt.present? ? excerpt : content.truncate(249)
  end
end
