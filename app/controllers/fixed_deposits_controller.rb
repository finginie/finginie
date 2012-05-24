class FixedDepositsController < InheritedResources::Base
  def collection
    @search = FixedDepositDetailProxy.new(params[:fixed_deposit_detail_proxy])
    if params[:fixed_deposit_detail_proxy]
      @fd_details = FixedDepositDetail.search(params[:fixed_deposit_detail_proxy])
      FixedDepositDetailsDecorator.custom_decorate(@fd_details)
    else
      @top_five_public_banks_interest_rates  ||= FixedDepositDetail.top_five_public_banks_interest_rates
      @top_five_private_banks_interest_rates ||= FixedDepositDetail.top_five_private_banks_interest_rates
    end
  end
end
