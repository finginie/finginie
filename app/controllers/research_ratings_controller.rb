class ResearchRatingsController < InheritedResources::Base
  actions :index

  def collection
    @companies = DataProvider::Company.nifty.sort_by(&:rating).reverse
    CompanyDecorator.decorate(@companies)
  end
end
