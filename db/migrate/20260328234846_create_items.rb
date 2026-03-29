class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.string     :name,        null: false
      t.text       :description
      t.string     :status,      null: false, default: "draft"
      t.references :shop,        null: false, foreign_key: true

      t.timestamps
    end

    add_index :items, [ :shop_id, :name ]
  end
end
