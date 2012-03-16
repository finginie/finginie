class FixedDepositTransactionsController < InheritedResources::Base
  belongs_to :portfolio

  custom_actions :resource => [ :redeem, :create_redeem ]

  def collection
    super.order("date DESC")
  end

  def create
    create!(:notice => "Fixed Deposit transaction was successfully added") { details_portfolio_path(parent) }
  end

  def create_redeem
    params[:fixed_deposit_transaction]["fixed_deposit_attributes"].delete "id"
    object = build_resource
    create_resource(object)
    create_redeem!{ redirect_to details_portfolio_path(parent), :notice => "Successfully redeemed your deposit" and return }
  end

end
