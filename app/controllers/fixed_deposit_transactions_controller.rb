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
    FixedDeposit.find(params[:fixed_deposit_transaction][:fixed_deposit_id]).update_attributes(:rate_of_redemption => params[:fixed_deposit_transaction][:rate_of_redemption])
    params[:fixed_deposit_transaction].delete(:rate_of_redemption)
    object = build_resource
    create_resource(object)
    create_redeem!{ redirect_to details_portfolio_path(parent), :notice => "Successfully redeemed your deposit" and return }
  end

end
