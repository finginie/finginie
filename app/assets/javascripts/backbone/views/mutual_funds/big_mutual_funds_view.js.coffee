Finginie.Views.MutualFunds ||= {}

class Finginie.Views.MutualFunds.BigMutualFundsView extends Backbone.View
  template: JST["backbone/templates/mutual_funds/big_mutual_funds"]

  initialize: () ->
    @options.mutual_funds.bind('reset', @addAll)

  addAll: () =>
    @options.mutual_funds.each(@addOne)

  addOne: (mutual_funds) =>
    view = new Finginie.Views.MutualFunds.BigMutualFundItemView({model : mutual_funds})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(mutual_funds: @options.mutual_funds.toJSON() ))
    @addAll()

    return this
