json.user do
  json.id user.id
  json.name user.name
  json.email user.email
  json.cellphone user.cellphone
end

json.shop do
  json.id user.shop.id
  json.name user.shop.name
end
