class AddDescriptionToDrug < ActiveRecord::Migration
  def change
    add_column :drugs, :description, :string
  end
end
