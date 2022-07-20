
Shop.destroy_all

5.times do |number|
  Shop.create!(
    name: "Shop #{number}",
    shop_opening_hours_attributes: [
      {
        day: 'monday',
        open_at: DateTime.new(1999, 6, 30, 8, 30),
        close_at: DateTime.new(1999, 6, 30, 20, 30),
        break_starts_at: DateTime.new(1999, 6, 30, 15, 30),
        break_ends_at: DateTime.new(1999, 6, 30, 16, 30),
        closed: false
      },
      {
        day: 'tuesday',
        open_at: DateTime.new(1999, 6, 30, 2, 30),
        close_at: DateTime.new(1999, 6, 30, 7, 30),
        closed: true
      },
      {
        day: 'wednesday',
        open_at: DateTime.new(1999, 6, 30, 8, 30),
        close_at: DateTime.new(1999, 6, 30, 20, 30),
        break_starts_at: DateTime.new(1999, 6, 30, 15, 30),
        break_ends_at: DateTime.new(1999, 6, 30, 16, 30),
        closed: false
      },
      {
        day: 'thursday',
        open_at: DateTime.new(1999, 6, 30, 18, 30),
        close_at: DateTime.new(1999, 6, 30, 20, 30),
        closed: false
      },
      {
        day: 'friday',
        open_at: DateTime.new(1999, 6, 30, 8, 30),
        close_at: DateTime.new(1999, 6, 30, 20, 30),
        closed: true
      },
      {
        day: 'saturday',
        open_at: DateTime.new(1999, 6, 30, 8, 30),
        close_at: DateTime.new(1999, 6, 30, 20, 30),
        break_starts_at: DateTime.new(1999, 6, 30, 15, 30),
        break_ends_at: DateTime.new(1999, 6, 30, 16, 30),
        closed: false
      },
      {
        day: 'sunday',
        open_at: DateTime.new(1999, 6, 30, 7, 30),
        close_at: DateTime.new(1999, 6, 30, 20, 30),
        break_starts_at: DateTime.new(1999, 6, 30, 14, 30),
        break_ends_at: DateTime.new(1999, 6, 30, 16, 30),
        closed: false
      }
    ]
  )
end