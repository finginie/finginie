Finginie.Views.MutualFunds ||= {}

class Finginie.Views.MutualFunds.ShowView extends Backbone.View
  template: JST["backbone/templates/mutual_funds/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
