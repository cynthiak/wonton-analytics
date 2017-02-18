module FormattingHelper

  def format_money(number)
    if number.to_f.nan?
      return '-'
    else
      return "$" + number_with_delimiter(number.round(2)).to_s
    end
  end

  def format_percentage(number)
    if number.to_f.nan?
      return '-'
    else
      return number_with_delimiter(number.round(2)).to_s + "%"
    end
  end

end