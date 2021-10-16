class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :termination_date
      t.decimal :total_charge
      t.integer :number_of_users

      t.references :user
      t.references :room

      t.timestamps

    end
  end
end
