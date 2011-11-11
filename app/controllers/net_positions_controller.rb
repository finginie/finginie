class NetPositionsController < InheritedResources::Base
  belongs_to :portfolio
  actions :all, :except => :index
end
