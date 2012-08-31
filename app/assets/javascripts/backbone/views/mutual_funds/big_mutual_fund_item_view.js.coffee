Finginie.Views.MutualFunds ||= {}

class Finginie.Views.MutualFunds.BigMutualFundItemView extends Backbone.View
  template: JST["backbone/templates/mutual_funds/big_mutual_fund_item"]

  tagName: "tr"

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend {},
      @model.toJSON(),
      @model.color_classes('percentage_change', 'prev_year_percent'),
      @model.round('percentage_change', 'size', 'prev_year_percent'),
      @model.slug('name')
