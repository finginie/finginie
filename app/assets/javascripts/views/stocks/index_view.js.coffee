Finginie.Views.Stocks ||= {}

class Finginie.Views.Stocks.IndexView extends Backbone.View
  template: JST["templates/stocks/index"]

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')

    @options.stocks.bind('reset', @render)

  addAll: () ->
    @options.stocks.each(@addOne)

  addOne: (stock) ->
    view = new Finginie.Views.Stocks.StockView({model : stock})
    @$("tbody").append(view.render().el)

  render: ->
    $(@el).html(@template(stocks: @options.stocks.toJSON() ))
    @addAll()

    return this
