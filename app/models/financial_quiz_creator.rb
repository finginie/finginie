class FinancialQuizCreator
  attr_reader :callbacks, :attributes

  def initialize(callbacks, attributes)
    @callbacks  = callbacks
    @attributes = attributes
  end

  def create_for(user)
    if not_valid_quiz_and_not_skipped_quiz?
      callbacks[:failure].call(comprehensive_risk_profiler)
    else
      if user
        save_quiz_data_for(user)
        callbacks[:success].call
      else
        callbacks[:restricted].call
      end
    end
  end

  private
    def save_quiz_data_for(user)
      if quiz_skipped?
        comprehensive_risk_profiler = user.build_comprehensive_risk_profiler(:score_cache => attributes[:score_cache])
        comprehensive_risk_profiler.save(:validate => false)
      else
        user.create_comprehensive_risk_profiler(attributes)
      end
    end

    def quiz_skipped?
      attributes.present? && attributes[:score_cache].present?
    end

    def not_valid_quiz_and_not_skipped_quiz?
      !comprehensive_risk_profiler.valid? && !quiz_skipped?
    end

    def comprehensive_risk_profiler
      @comprehensive_risk_profiler ||= ComprehensiveRiskProfiler.new attributes
    end
end