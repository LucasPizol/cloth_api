class CreateItemVariants < ActiveRecord::Migration[8.1]
  def change
    create_table :item_variants do |t|
      t.string     :sku
      t.integer    :price_cents,     null: false, default: 0
      t.string     :price_currency,  null: false, default: "BRL"
      t.integer    :stock_quantity,  null: false, default: 0
      t.boolean    :track_inventory, null: false, default: true
      t.references :item,            null: false, foreign_key: true

      t.timestamps
    end

    add_index :item_variants, :sku, unique: true, where: "sku IS NOT NULL"
  end
end
