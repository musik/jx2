class Post < ActiveRecord::Base
  attr_accessible :author, :content, :laiyuan, :laiyuan_url, :publish, :title,:seo_title,:excerpt,:keywords,:post_type_cd,:post_type,:related
  scope :recent,order("id desc")
  scope :published,where(:publish=>true)
  as_enum :post_type,
    :news => 0,
    :wiki => 1,
    :ask => 2
  define_index do
    indexes :title
    indexes :content
    indexes :related
    has :post_type_cd
    set_property :delta => ThinkingSphinx::Deltas::ResqueDelta
  end
  def description
    excerpt.present? ? excerpt : content.truncate(249)
  end
  def path
    "/#{post_type}/#{id}"
  end
  def prev
    self.class.published.recent.where("id < ?",id).first
  end
  def next
    self.class.published.where("id > ?",id).first
  end
end
