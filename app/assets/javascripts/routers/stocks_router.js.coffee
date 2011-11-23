class Finginie.Routers.StocksRouter extends Backbone.Router
  initialize: (options) ->
    @stocks = new Finginie.Collections.StocksCollection()
    @stocks.reset options.stocks

  routes:
    "/:id"            : "show"
    ".*"              : "index"

  index: ->
    @view = new Finginie.Views.Stocks.IndexView(stocks: @stocks)
    @search = new Finginie.Views.Stocks.SearchView(stocks: @stocks)
    $("#stocks").html(@view.render().el)

  show: (id) ->
    stock = @stocks.get(id)

    @view = new Finginie.Views.Stocks.ShowView(model: stock)
    $("#stock").html(@view.render().el)
