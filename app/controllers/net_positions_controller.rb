class NetPositionsController < InheritedResources::Base
  belongs_to :portfolio
  actions :all, :except => [:index]

  def create
    create!(:notice => t(".net_positions.success_message")) { portfolio_path(@net_position.portfolio_id) }
  end
end
