module ApplicationHelper
  def current_day
    Time.zone.now.strftime('%A')
  end

  def ordered_days
    Date::DAYNAMES.rotate(Date::DAYNAMES.find_index(current_day))
  end

  def presenter(current_opening_hour)
    "#{I18n.t("activerecord.attributes.shop_opening_hour.days.#{current_opening_hour.day}")} #{current_opening_hour.open_at.strftime('%Hh%M')}-#{current_opening_hour.break_starts_at.strftime('%Hh%M')} #{current_opening_hour.break_ends_at.strftime('%Hh%M')}-#{current_opening_hour.close_at.strftime('%Hh%M')}"
  end
end
