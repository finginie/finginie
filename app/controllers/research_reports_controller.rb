class ResearchReportsController < InheritedResources::Base

  def collection
    ResearchReport.filter(params[:query])
  end
end
