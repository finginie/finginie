Finginie.Views.Scrips ||= {}

class Finginie.Views.Scrips.MostActiveShareView extends Backbone.View
  template: JST["backbone/templates/scrips/most_active_share"]

  tagName: "tr"

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend {},
      @model.toJSON(),
      @model.round('last_traded_price')
