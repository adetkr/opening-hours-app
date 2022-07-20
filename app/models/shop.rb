class Shop < ApplicationRecord
  has_many :shop_opening_hours, inverse_of: :shop, dependent: :destroy
  accepts_nested_attributes_for :shop_opening_hours, allow_destroy: true
  validates_associated :shop_opening_hours

  validates :name, presence: true, uniqueness: true
end
