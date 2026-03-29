class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :cellphone
      t.string :email
      t.string :password_digest, null: false
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end

    add_index :users, :email, unique: true, where: "email IS NOT NULL"
    add_index :users, :cellphone, unique: true, where: "cellphone IS NOT NULL"
  end
end
