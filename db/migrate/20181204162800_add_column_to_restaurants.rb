class AddColumnToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :url, :string
  end
end
