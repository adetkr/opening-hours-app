module ShopsHelper
  def presenter(current_opening_hour)
    day = I18n.t("activerecord.attributes.shop_opening_hour.days.#{current_opening_hour.day}")
    return  "#{day}  Fermé" if current_opening_hour.closed?
  
    return "#{day}  #{current_opening_hour.open_at.strftime('%Hh%M')}-#{current_opening_hour.break_starts_at.strftime('%Hh%M')}, #{current_opening_hour.break_ends_at.strftime('%Hh%M')}-#{current_opening_hour.close_at.strftime('%Hh%M')}" if current_opening_hour.break_hours_filled?
  
    "#{day}  #{current_opening_hour.open_at.strftime('%Hh%M')}-#{current_opening_hour.close_at.strftime('%Hh%M')}"
  end
end