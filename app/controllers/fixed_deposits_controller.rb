class FixedDepositsController < InheritedResources::Base
  def collection
    @search = FixedDepositDetailDecorator.decorate(FixedDepositDetail.new(params[:fixed_deposit_detail]))
    if params[:fixed_deposit_detail]
      @fd_details = FixedDepositCollection.search(params[:fixed_deposit_detail])
      FixedDepositDetailsDecorator.custom_decorate(@fd_details)
    else
      @top_five_public_banks_interest_rates  ||= FixedDepositCollection.top_five_public_banks_interest_rates
      @top_five_private_banks_interest_rates ||= FixedDepositCollection.top_five_private_banks_interest_rates
    end
  end
end
