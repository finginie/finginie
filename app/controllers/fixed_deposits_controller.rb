class FixedDepositsController < InheritedResources::Base
  def collection
    @search = FixedDepositQueryDecorator.decorate(FixedDepositQuery.new(params[:fixed_deposit_query]))
    if params[:fixed_deposit_query] && @search.valid?
      @fd_details = FixedDepositCollection.search(params[:fixed_deposit_query])
      FixedDepositDetailsDecorator.custom_decorate(@fd_details)
    else
      @top_five_public_banks_interest_rates  ||= FixedDepositCollection.top_five_public_banks_interest_rates
      @top_five_private_banks_interest_rates ||= FixedDepositCollection.top_five_private_banks_interest_rates
    end
  end
end
