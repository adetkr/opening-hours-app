class Shop < ApplicationRecord
  has_many :shop_opening_hours, inverse_of: :shop, dependent: :destroy
  accepts_nested_attributes_for :shop_opening_hours, allow_destroy: true
  validates_associated :shop_opening_hours

  validates :name, presence: true, uniqueness: true

  def opening_hour(day)
    shop_opening_hours.find { |opening_hour| opening_hour.day == day }
  end
end
