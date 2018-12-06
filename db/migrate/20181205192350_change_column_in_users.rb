class ChangeColumnInUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :img_url, :string, default: nil
  end
end
