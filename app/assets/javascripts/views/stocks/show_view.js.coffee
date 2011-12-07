Finginie.Views.Stocks ||= {}

class Finginie.Views.Stocks.ShowView extends Backbone.View
  template: JST["templates/stocks/show"]

  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    return this
