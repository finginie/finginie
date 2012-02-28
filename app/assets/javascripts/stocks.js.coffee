$ ->
  net_change = parseFloat($(".daily_price_change > .net_change").text())
  percentage_change = parseFloat($(".daily_price_change > .percent_change").text().slice(1,-2))
  if net_change < 0.0
    $(".daily_price_change > .net_change").css('color', 'red')
  else
    $(".daily_price_change > .net_change").css('color', 'green')

  if percentage_change < 0.0
    $(".daily_price_change > .percent_change").css('color', 'red')
  else
    $(".daily_price_change > .percent_change").css('color', 'green')
