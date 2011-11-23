Finginie.Views.Stocks ||= {}

class Finginie.Views.Stocks.StockView extends Backbone.View
  template: JST["templates/stocks/stock"]
  tagName: "tr"

  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    return this
