class AddShouziToChengfen < ActiveRecord::Migration
  def change
    add_column :chengfens, :shouzi, :string
    add_column :drugs, :shouzi, :string
    Chengfen.find_each do |c|
      c.update_attribute :shouzi,c.name[0]
    end
    Drug.find_each do |c|
      c.update_attribute :shouzi,c.name[0]
    end
  end
end
