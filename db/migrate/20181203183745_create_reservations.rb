class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :restaurant, foreign_key: true
      t.references :group, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end
