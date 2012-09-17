class ComprehensiveRiskProfilersController < InheritedResources::Base
  defaults :singleton => true
  actions :edit, :update

  def update
    if not_valid_quiz_and_not_skipped_quiz?
      @comprehensive_risk_profiler = ComprehensiveRiskProfilerDecorator.decorate(comprehensive_risk_profiler)
      render :edit
    else
      if current_user
        save_quiz_data
        redirect_to comprehensive_risk_profiler_ideal_investments_path, :notice =>t(".comprehensive_risk_profilers.success_message")
      else
        session[:comprehensive_risk_profiler] = params[:comprehensive_risk_profiler]
        redirect_to login_and_go_to(comprehensive_risk_profiler_ideal_investments_path)
      end
    end
  end

  def edit
      comprehensive_risk_profiler  = (current_user && current_user.comprehensive_risk_profiler) || ComprehensiveRiskProfiler.new(session[:comprehensive_risk_profiler])
      @comprehensive_risk_profiler = ComprehensiveRiskProfilerDecorator.decorate(comprehensive_risk_profiler)
    end
  end

  private
  def save_quiz_data
    if quiz_skipped?
      comprehensive_risk_profiler = current_user.build_comprehensive_risk_profiler(:score_cache => attributes[:score_cache])
      comprehensive_risk_profiler.save(:validate => false)
    else
      current_user.create_comprehensive_risk_profiler(attributes)
    end
  end

  def quiz_skipped?
    params[:comprehensive_risk_profiler].present? && params[:comprehensive_risk_profiler][:score_cache].present?
  end

  def not_valid_quiz_and_not_skipped_quiz?
    !comprehensive_risk_profiler.valid? && !quiz_skipped?
  end

  def comprehensive_risk_profiler
    comprehensive_risk_profiler = ComprehensiveRiskProfiler.new(params[:comprehensive_risk_profiler])
  end
end
