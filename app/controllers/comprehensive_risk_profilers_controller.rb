class ComprehensiveRiskProfilersController < InheritedResources::Base
  defaults :singleton => true
  actions :show, :edit, :update

  def show
    if first_time?
      redirect_to edit_comprehensive_risk_profiler_path, :notice => t(".comprehensive_risk_profilers.message")
    else
      show!
    end
  end

  def update
    update!(:notice =>t(".comprehensive_risk_profilers.success_message"))
  end

  def resource
    @comprehensive_risk_profiler ||= current_user && current_user.comprehensive_risk_profiler || ComprehensiveRiskProfiler.new(session[:comprehensive_risk_profiler])
    ComprehensiveRiskProfilerDecorator.decorate(@comprehensive_risk_profiler)
  end

  def update_resource(object, attributes)
    if current_user
      super
    else
      object.attributes = attributes.first
      session[:comprehensive_risk_profiler] = attributes.first if object.valid?
      object
    end
  end

private
  def first_time?
    current_user ? current_user.comprehensive_risk_profiler.update_attribute(:score_cache, params[:score]) : session[:comprehensive_risk_profiler] = {score_cache: params[:score]} if params[:score]
    !(current_user && current_user.comprehensive_risk_profiler.persisted? || session[:comprehensive_risk_profiler])
  end
end
