class ShopOpeningHour < ApplicationRecord
  belongs_to :shop

  validates :day, :open_at, :close_at, presence: true
  validates :break_starts_at, presence: true, if: :break_ends_at?
  validates :break_ends_at, presence: true, if: :break_starts_at?

  validate :opening_hours_coherence

  validates :day, uniqueness: { scope: %i[shop_id] }

  enum day: {
    monday: 0,
    tuesday: 1,
    wednesday: 2,
    thursday: 3,
    friday: 4,
    saturday: 5,
    sunday: 6,
  }

  def break_hours_filled?
    break_starts_at.present? && break_ends_at.present? && break_starts_at.strftime('%H%M') != '0000' && break_ends_at.strftime('%H%M') != '0000'
  end

  protected

  def opening_hours_coherence
    return if closed

    errors.add(:close_at, "L'horaire de fermeture du magasin doit être après l'horaire d'ouverture du magasin") if close_at && open_at && open_at >= close_at
    errors.add(:close_at, "L'horaire de fermeture du magasin doit être après l'horaire de la fin de pause") if break_hours_filled? && close_at && break_ends_at >= close_at
    errors.add(:break_ends_at, "L'horaire de la fin de pause doit être après l'horaire du début de la pause") if break_hours_filled? && break_ends_at && break_starts_at >= break_ends_at
    errors.add(:break_starts_at, "L'horaire du début de la pause doit être après l'horaire d'ouverture du magasin") if break_hours_filled? && open_at && open_at >= break_starts_at
  end
end
