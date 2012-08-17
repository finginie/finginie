class IdealInvestmentsController < InheritedResources::Base
  defaults :singleton => true, :resource_class => IdealInvestmentMix, :instance_name => 'ideal_investment_mix'
  before_filter :user_logged_in, :only => [:show]

  def public
    @user = User.find(params[:id])
    session[:referrer_id] ||= @user.id
    quiz_link = "<a href='/comprehensive_risk_profiler/edit'>Click Here</a>"
    flash.now[:notice] = (I18n.t('.comprehensive_risk_profilers.public.personalize_message', :email => @user.email, :quiz_link => quiz_link)).html_safe
    @comprehensive_risk_profiler = ComprehensiveRiskProfilerDecorator.decorate(@user.comprehensive_risk_profiler)
    @ideal_investment_mix = IdealInvestmentMix.new(@comprehensive_risk_profiler)
  end

  def resource
    @resource = super
    @resource.initial_investment = (params[:initial_investment]) if params[:initial_investment]
    starting_investment = @resource.comprehensive_risk_profiler.initial_investment
    flash.now[:notice] =  starting_investment > IdealInvestmentMix::MINIMUM_INVESTMENT ? t('.display_initial_investment', :amount => starting_investment) : t('.too_low_investment')
    @resource
  end

protected
  def begin_of_association_chain
    @current_user.comprehensive_risk_profiler
  end

  def user_logged_in
    unless @current_user && @current_user.comprehensive_risk_profiler.persisted?
      flash.keep(:notice)
      redirect_to edit_comprehensive_risk_profiler_path
    end
  end
end
