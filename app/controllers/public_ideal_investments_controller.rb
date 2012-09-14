class PublicIdealInvestmentsController < InheritedResources::Base
  actions :show
  defaults :resource_class => Portfolio

  def show
    session[:referrer_id] ||= params[:id]
    show!
  end

  def resource
    @public_ideal_investment ||= begin
      user = User.find params[:id]
      IdealInvestmentPresenter.new(user, :public => true)
    end
  end

end
