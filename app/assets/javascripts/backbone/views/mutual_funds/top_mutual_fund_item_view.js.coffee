Finginie.Views.MutualFunds ||= {}

class Finginie.Views.MutualFunds.TopMutualFundItemView extends Backbone.View
  template: JST["backbone/templates/mutual_funds/top_mutual_fund_item"]

  tagName: "tr"

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend {},
      @model.toJSON(),
      @color_classes('percentage_change', 'prev1_month_percent', 'prev_year_percent', 'prev3_year_percent'),
      @round('percentage_change', 'prev1_month_percent', 'prev_year_percent', 'prev3_year_percent'),
      { slug: string_to_slug(@model.get('name')) }

  color_classes: (attrs...)->
    color_classes = {}
    for attr in attrs
      value = @model.get attr
      color_classes["#{attr}_color"] = if value?
        if value < 0 then 'red' else 'green'
    color_classes

  round: (attrs...)->
    ret = {}
    for attr in attrs
      ret[attr] = Math.round(@model.get(attr) * 100)/100
    ret
