class TransactionsController < InheritedResources::Base
  nested_belongs_to :portfolio, :net_position
  actions :all, :except => [:show]

  def index
    @transactions = Transaction.statement(params[:portfolio_id])
  end
end
