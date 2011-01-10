module ApplicationHelper

  def display_date(input_date)
    return input_date.strftime("%d/%m %H:%M")
  end

end
