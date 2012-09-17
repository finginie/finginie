class FinancialQuizCreator
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def create_for(user)
    return false unless user
    save_quiz_data_for(user)
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
end
