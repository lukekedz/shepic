module ApplicationHelper
  def game_day(date)
    date.strftime("%a %m/%d").upcase
  end

  def convert_military_to_ampm(military_time_str)
    ampm_time = ""

    if military_time_str[0..1] == "12"
      ampm_time = military_time_str[0..1]
    else
      ampm_time = (military_time_str[0..1].to_i - 12).to_s
    end

    ampm_time += ":" + military_time_str[2..3] + "pm"
  end
end
