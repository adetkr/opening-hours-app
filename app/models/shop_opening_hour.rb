class ShopOpeningHour < ApplicationRecord
  belongs_to :shop

  validates :day, :open_at, :close_at, presence: true
  validates :break_starts_at, presence: true, if: :break_ends_at?
  validates :break_ends_at, presence: true, if: :break_starts_at?

  enum day: {
    monday: 0,
    tuesday: 1,
    wednesday: 2,
    thursday: 3,
    friday: 4,
    saturday: 5,
    sunday: 6,
  }
end
