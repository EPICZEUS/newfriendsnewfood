class ChangeColumnInRestaurant < ActiveRecord::Migration[5.2]
  def change
  	change_column :restaurants, :rating, :float
  end
end
