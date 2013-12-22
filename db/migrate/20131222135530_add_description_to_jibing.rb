class AddDescriptionToJibing < ActiveRecord::Migration
  def change
    add_column :jibings, :description, :text
  end
end
