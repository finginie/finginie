Finginie.Views.Scrips ||= {}

class Finginie.Views.Scrips.MostActiveSharesView extends Backbone.View
  template: JST["backbone/templates/scrips/most_active_shares"]

  initialize: () ->
    @options.scrips.bind('reset', @addAll)

  addAll: () =>
    @options.scrips.each(@addOne)

  addOne: (scrip) =>
    view = new Finginie.Views.Scrips.MostActiveShareView({model : scrip})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(scrips: @options.scrips.toJSON() ))
    @addAll()

    return this
