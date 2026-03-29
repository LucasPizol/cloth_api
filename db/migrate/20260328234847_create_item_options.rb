class CreateItemOptions < ActiveRecord::Migration[8.1]
  def change
    create_table :item_options do |t|
      t.string     :name,     null: false
      t.integer    :position, null: false, default: 0
      t.references :item,     null: false, foreign_key: true

      t.timestamps
    end

    add_index :item_options, [ :item_id, :name ],     unique: true
    add_index :item_options, [ :item_id, :position ]
  end
end
