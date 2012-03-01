$ ->
  net_change = parseFloat($(".daily_price_change > .net_change").text())
  percentage_change = parseFloat($(".daily_price_change > .percent_change").text().slice(1,-2))
  if net_change < 0.0
    $("body.stocks.show .daily_price_change > .net_change").removeClass('green').addClass('red')
  else
    $("body.stocks.show .daily_price_change > .net_change").removeClass('red').addClass('green')

  if percentage_change < 0.0
    $("body.stocks.show .daily_price_change > .percent_change").removeClass('green').addClass('red')
  else
    $("body.stocks.show .daily_price_change > .percent_change").removeClass('red').addClass('green')
