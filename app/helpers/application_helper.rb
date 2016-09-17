module ApplicationHelper

  def game_day(date)
    date.strftime("%A, %b %e")
  end

end
