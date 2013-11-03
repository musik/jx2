class Comment < ActiveRecord::Base
  include Rakismet::Model
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

  validates_presence_of :author_name
  validates_presence_of :author_email
  validates_presence_of :body

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable
  attr_accessible :body,:commentable_id,:commentable_type,:user_id,:author_name,:author_email,:author_ip

  belongs_to :commentable, :polymorphic => true
  scope :recent,order('id desc')

  # NOTE: Comments belong to a user
  belongs_to :user
  #rakismet_attrs :author=>proc{user.name},:author_email=>proc{user.email}
  #rakismet_attrs :author=>'Sacramento computer repair',:author_email=>'leroy_denny@hotmail.de',:content=>:body

  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, data)
    c = self.new data
    c.commentable_id = obj.id
    c.commentable_type = obj.class.base_class.name
    c
  end

  #helper method to check if a comment has children
  def has_children?
    self.children.size > 0
  end

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end
end
