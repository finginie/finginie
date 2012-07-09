class ResearchReportsController < InheritedResources::Base
  optional_belongs_to :stock, :parent_class => DataProvider::Company, :finder => :find_by_slug, :instance_name => 'company'

  def collection
    @search = DataProvider::Company.new
    conditions = { :query => params[:query] }
    conditions.merge!({ :nse_code => parent.nse_code, :bse_code => parent.bse_code1 }) if parent
    @reports = ResearchReport.filter(conditions)
    flash.now[:result] = @reports.empty? ? t('.empty_search') : (t('.results_for_search', :term => params[:query]) if params[:query])
    @reports
  end
end
