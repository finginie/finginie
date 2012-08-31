Finginie.Views.ResearchReports ||= {}

class Finginie.Views.ResearchReports.ResearchReportView extends Backbone.View
  template: JST["backbone/templates/research_reports/research_report"]

  tagName: "li"

  render: =>
    $(@el).html(@template(@model.toJSON()))
    return this

