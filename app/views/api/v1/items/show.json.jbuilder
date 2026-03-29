json.item do
  json.id          @item.id
  json.name        @item.name
  json.description @item.description
  json.status      @item.status
  json.created_at  @item.created_at
  json.updated_at  @item.updated_at

  json.item_options @item.item_options do |option|
    json.id       option.id
    json.name     option.name
    json.position option.position

    json.item_option_values option.item_option_values do |value|
      json.id       value.id
      json.value    value.value
      json.position value.position
    end
  end

  json.item_variants @item.item_variants do |variant|
    json.id                   variant.id
    json.sku                  variant.sku
    json.price_cents          variant.price_cents
    json.price_currency       variant.price_currency
    json.stock_quantity       variant.stock_quantity
    json.track_inventory      variant.track_inventory
    json.item_option_value_ids variant.item_option_value_ids
  end
end
