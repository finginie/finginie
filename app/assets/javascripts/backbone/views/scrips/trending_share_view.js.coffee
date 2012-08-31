Finginie.Views.Scrips ||= {}

class Finginie.Views.Scrips.TrendingShareView extends Backbone.View
  template: JST["backbone/templates/scrips/trending_share"]

  tagName: "tr"

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend {},
      @model.toJSON(),
      @model.color_classes('percent_change'),
      @model.round('last_traded_price', 'percent_change')
