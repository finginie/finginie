class ComprehensiveRiskProfilersController < InheritedResources::Base
  defaults :singleton => true
  actions :edit, :update

  def update
    financial_quiz_creator = FinancialQuizCreator.new(callbacks, params[:comprehensive_risk_profiler])
    financial_quiz_creator.create_for(current_user)
  end

  def edit
    comprehensive_risk_profiler  = (current_user && current_user.comprehensive_risk_profiler) || ComprehensiveRiskProfiler.new(session[:comprehensive_risk_profiler])
    @comprehensive_risk_profiler = ComprehensiveRiskProfilerDecorator.decorate(comprehensive_risk_profiler)
  end

  private
    def callbacks
      %w(success failure restricted).inject({}) do |result, callback|
        result[callback] = lambda(&method(callback))
        result
      end.with_indifferent_access
    end

    def success
      redirect_to comprehensive_risk_profiler_ideal_investments_path, :notice =>t(".comprehensive_risk_profilers.success_message")
    end

    def failure(comprehensive_risk_profiler)
      @comprehensive_risk_profiler = ComprehensiveRiskProfilerDecorator.decorate(comprehensive_risk_profiler)
      render :edit
    end

    def restricted
      session[:comprehensive_risk_profiler] = params[:comprehensive_risk_profiler]
      redirect_to comprehensive_risk_profiler_ideal_investments_path
    end
end
