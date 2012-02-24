class NetPositionsController < InheritedResources::Base
  belongs_to :portfolio
  actions :all, :except => [:index]

  def create
    create!{ portfolio_path(@net_position.portfolio_id) }
  end
end
