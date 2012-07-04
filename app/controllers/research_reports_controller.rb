class ResearchReportsController < InheritedResources::Base
  optional_belongs_to :stock, :parent_class => DataProvider::Company, :finder => :find_by_slug

  def collection
    conditions = { :query => params[:query] }
    conditions.merge!({ :nse_code => parent.nse_code, :bse_code => parent.bse_code1 }) if parent
    ResearchReport.filter(conditions)
  end
end
