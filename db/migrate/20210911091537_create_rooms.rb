class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :introduction
      t.decimal :charge
      t.text :address
      t.references :user

      t.timestamps
    end
  end
end
