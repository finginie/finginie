class TransactionsController < InheritedResources::Base
  nested_belongs_to :portfolio, :net_position
  actions :all, :except => [:show, :index]

  def create
    create!{ portfolio_path(@transaction.net_position.portfolio_id) }
  end

  def update
    update!{ portfolio_path(resource.net_position.portfolio_id) }
  end
end
