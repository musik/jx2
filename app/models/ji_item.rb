class JiItem < ActiveRecord::Base
  belongs_to :jibing
  acts_as_list scope: :jibing
  belongs_to :drug
  attr_accessible :likes, :position
end
