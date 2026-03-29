class CreateShops < ActiveRecord::Migration[8.1]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :cnpj, null: false

      t.timestamps
    end

    add_index :shops, :cnpj, unique: true
  end
end
