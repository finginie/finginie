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

  def show
    comprehensive_risk_profiler = current_user.comprehensive_risk_profiler
    financial_planner = FinancialPlanner.new(comprehensive_risk_profiler.score)
    amount = params[:initial_investment] || comprehensive_risk_profiler.initial_investment
    ideal_investment_mix = IdealInvestmentMix.new(financial_planner, amount)
    @ideal_investment_mix_decorator = IdealInvestmentMixDecorator.decorate(ideal_investment_mix)
    @decorated_comprehensive_risk_profiler = ComprehensiveRiskProfilerDecorator.decorate(comprehensive_risk_profiler)
    unless flash['error'] || flash['notice']
      flash[:notice] = @ideal_investment_mix_decorator.flash_message
    end
  end

protected
  def user_logged_in
    unless current_user && current_user.comprehensive_risk_profiler.persisted?
      flash.keep(:notice)
      redirect_to edit_comprehensive_risk_profiler_path
    end
  end
end
