class Shop < ApplicationRecord
  has_many :shop_opening_hours, inverse_of: :shop, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
