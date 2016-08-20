module ApplicationHelper

  def game_day(date)
    day = Time.new("20" + date[6..7], date[0..1], date[3..4]).strftime("%A")

    date = day + " " + date
  end

end
