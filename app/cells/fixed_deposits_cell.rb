class FixedDepositsCell < Cell::Rails
  helper ApplicationHelper

  def special_tenure
    @search = params[:fixed_deposit_detail]
    @fd_details = FixedDepositCollection.special_tenure(@search)
    render
  end

end
