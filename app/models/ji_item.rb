class JiItem < ActiveRecord::Base
  belongs_to :jibing,:counter_cache=>'items_count'
  acts_as_list scope: :jibing
  belongs_to :drug
  attr_accessible :likes, :position, :jibing_id,:drug_id
  scope :inlist,lambda{|jibing| where(:jibing_id=>jibing.id).includes(:drug)}
end
