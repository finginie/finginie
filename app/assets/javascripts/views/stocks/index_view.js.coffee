Finginie.Views.Stocks ||= {}

class Finginie.Views.Stocks.IndexView extends Backbone.View
  template: JST["templates/stocks/index"]
  el: '#stocks'

  initialize: () ->
    @options.stocks.bind('reset', @render)

  addAll: () =>
    if @options.stocks.length == 0
      @$("tbody").append("<td colspan=5 class=norecords >Your search didnt return any results.Try another word instead.</td>")
    else
      @options.stocks.each(@addOne)

  addOne: (stock) =>
    view = new Finginie.Views.Stocks.StockView({model : stock})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(stocks: @options.stocks.toJSON() ))
    @addAll()

    this
