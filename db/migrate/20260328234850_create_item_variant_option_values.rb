class CreateItemVariantOptionValues < ActiveRecord::Migration[8.1]
  def change
    create_table :item_variant_option_values do |t|
      t.references :item_variant,      null: false, foreign_key: true
      t.references :item_option_value, null: false, foreign_key: true

      t.timestamps
    end

    add_index :item_variant_option_values,
              [ :item_variant_id, :item_option_value_id ],
              unique: true,
              name: "index_variant_option_values_uniqueness"
  end
end
