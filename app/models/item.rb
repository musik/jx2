class Item < ActiveRecord::Base
  belongs_to :yaopin
  attr_accessible :price, :scope, :title, :url
  after_create :update_drug_items_count
  def update_drug_items_count
    yaopin.drug.update_items_count
  end
end
