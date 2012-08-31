Finginie.Views.MutualFunds ||= {}

class Finginie.Views.MutualFunds.TrendingMutualFundItemView extends Backbone.View
  template: JST["backbone/templates/mutual_funds/trending_mutual_fund_item"]

  tagName: "tr"

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend {},
      @model.toJSON(),
      @model.color_classes('percentage_change', 'prev1_month_percent', 'prev_year_percent', 'prev3_year_percent'),
      @model.round('percentage_change', 'prev1_month_percent', 'prev_year_percent', 'prev3_year_percent'),
      @model.slug('name')
