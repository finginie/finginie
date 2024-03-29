class PublicIdealInvestmentsController < InheritedResources::Base
  actions :show

  def show
    session[:referrer_id] ||= params[:id]
    show!
  end

  def resource
    @public_ideal_investment ||= begin
      user = User.find params[:id]
      user.ideal_investment(:public => true)
    end
  end

end
