class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :neighborhood
      t.string :state
      t.string :country
      t.string :number
      t.string :complement
      t.references :owner, polymorphic: true, null: false

      t.timestamps
    end
  end
end
