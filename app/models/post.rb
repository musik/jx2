class Post < ActiveRecord::Base
  attr_accessible :author, :content, :laiyuan, :laiyuan_url, :publish, :title,:seo_title,:excerpt,:keywords,:post_type_cd,:post_type,:related
  scope :recent,order("id desc")
  scope :published,where(:publish=>true)
  as_enum :post_type,
    :news => 0,
    :wiki => 1,
    :ask => 2
  def description
    excerpt.present? ? excerpt : content.truncate(249)
  end
  def path
    "/#{post_type}/#{id}"
  end
end
