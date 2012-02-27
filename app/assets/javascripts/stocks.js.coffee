$ ->
  net_change = parseFloat($(".daily_price_change > strong").text())
  percentage_change = parseFloat($(".daily_price_change > span").text().slice(1,-2))
  if net_change < 0.0
    $(".daily_price_change > strong").css('color', 'red')
  else
    $(".daily_price_change > strong").css('color', 'green')

  if percentage_change < 0.0
    $(".daily_price_change > span").css('color', 'red')
  else
    $(".daily_price_change > span").css('color', 'green')
