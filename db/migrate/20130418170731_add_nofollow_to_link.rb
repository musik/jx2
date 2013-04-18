class AddNofollowToLink < ActiveRecord::Migration
  def change
    add_column :links, :nofollow, :boolean,:default=>false
    add_column :links, :favicon_type, :integer,:default=>1
  end
end
