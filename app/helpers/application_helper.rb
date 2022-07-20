module ApplicationHelper
  def current_day
    Time.zone.now.strftime('%A')
  end

  def ordered_days
    Date::DAYNAMES.rotate(Date::DAYNAMES.find_index(current_day))
  end
end
