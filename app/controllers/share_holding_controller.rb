class ShareHoldingController < InheritedResources::Base
  belongs_to :stock, :singleton => true
  actions :show

  def resource
    @search = Stock.search
    @share_holding = ShareHolding.all(conditions: { company_code: parent.company_code }, sort: [[ :share_holding_date, :desc ]], limit: 1).first
    @share_holding = ShareHoldingDecorator.decorate(@share_holding)
  end
end
