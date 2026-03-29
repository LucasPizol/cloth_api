json.item_variant do
  json.id                    @variant.id
  json.sku                   @variant.sku
  json.price_cents           @variant.price_cents
  json.price_currency        @variant.price_currency
  json.stock_quantity        @variant.stock_quantity
  json.track_inventory       @variant.track_inventory
  json.item_option_value_ids @variant.item_option_value_ids
  json.item_id               @variant.item_id
end
