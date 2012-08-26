Finginie.Views.MutualFunds ||= {}

class Finginie.Views.MutualFunds.MutualFundsView extends Backbone.View
  template: JST["backbone/templates/mutual_funds/mutual_funds"]

  tagName: "tr"

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend @model.toJSON(),
      percentage_change:          @round    @model.get('percentage_change')
      percentage_change_color:    @colorize @model.get('percentage_change')
      prev1_month_percent:        @round    @model.get('prev1_month_percent')
      prev1_month_percent_color:  @colorize @model.get('prev1_month_percent')
      prev_year_percent:          @round    @model.get('prev_year_percent')
      prev_year_percent_color:    @colorize @model.get('prev_year_percent')
      prev3_year_percent:         @round    @model.get('prev3_year_percent')
      prev3_year_percent_color:   @colorize @model.get('prev3_year_percent')

  colorize: (value)->
    if value?
      if value < 0 then 'red' else 'green'

  round: (value)->
    Math.round(value * 100)/100
