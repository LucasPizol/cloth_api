json.items @items do |item|
  json.id           item.id
  json.name         item.name
  json.description  item.description
  json.status       item.status
  json.created_at   item.created_at
  json.updated_at   item.updated_at
  json.variants_count item.item_variants.size
  json.options_count  item.item_options.size
end
