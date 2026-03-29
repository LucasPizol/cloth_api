class CreateItemOptionValues < ActiveRecord::Migration[8.1]
  def change
    create_table :item_option_values do |t|
      t.string     :value,       null: false
      t.integer    :position,    null: false, default: 0
      t.references :item_option, null: false, foreign_key: true

      t.timestamps
    end

    add_index :item_option_values, [ :item_option_id, :value ],    unique: true
    add_index :item_option_values, [ :item_option_id, :position ]
  end
end
