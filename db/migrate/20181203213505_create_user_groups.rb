class CreateUserGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :user_groups do |t|
      t.reference :user
      t.reference :group

      t.timestamps
    end
  end
end
