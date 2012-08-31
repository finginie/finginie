Finginie.Views.MutualFunds ||= {}

class Finginie.Views.MutualFunds.TrendingMutualFundsView extends Backbone.View
  template: JST["backbone/templates/mutual_funds/trending_mutual_funds"]

  initialize: () ->
    @options.mutual_funds.bind('reset', @addAll)

  addAll: () =>
    @options.mutual_funds.each(@addOne)

  addOne: (mutual_funds) =>
    view = new Finginie.Views.MutualFunds.TrendingMutualFundItemView({model : mutual_funds})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(mutual_funds: @options.mutual_funds.toJSON() ))
    @addAll()

    return this
