shop = Shop.find_or_create_by!(cnpj: "12.345.678/0001-99") do |s|
  s.name = "Emy Store"
end

User.find_or_create_by!(email: "admin@emy.com") do |u|
  u.name = "Admin"
  u.cellphone = "11999998888"
  u.password = "password123"
  u.shop = shop
end
