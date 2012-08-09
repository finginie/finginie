class ResearchRatingsController < InheritedResources::Base
  actions :index

  def collection
    DataProvider::Company.nifty.sort_by(&:rating).reverse
  end
end
