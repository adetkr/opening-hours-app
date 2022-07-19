
Shop.destroy_all

10.times do |number|
  Shop.create!(name: "Shop #{number}")
end