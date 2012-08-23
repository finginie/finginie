Finginie.Views.Indices ||= {}

class Finginie.Views.Indices.IndicesView extends Backbone.View
  template: JST["backbone/templates/indices/indices"]

  initialize: () ->
    # @options.indices.bind('reset', @addAll)

  addAll: () =>
    for index in @options.indices
      @addOne index

  addOne: (index) =>
    view = new Finginie.Views.Indices.IndexView({model : index})
    @$("span[data-role=market_indices]").append(view.render().el)

  render: =>
    $(@el).html(@template(indices: @options.indices ))
    @addAll()

    return this
