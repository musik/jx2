class AddRelatedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :related, :string
  end
end
