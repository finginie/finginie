class SessionsHandler
  attr_reader :user, :attributes

  def initialize(user)
    @user = user
  end

  def success_callback(session_hash)
    @attributes = session_hash
    save_comprehensive_risk_profiler_from_session unless user.has_comprehensive_risk_profiler?
    PointTracker::SignUpStep.new(user).save
  end

  private
  def save_comprehensive_risk_profiler_from_session
    if is_quiz_skipped?
      comprehensive_risk_profiler = user.build_comprehensive_risk_profiler(:score_cache => attributes[:comprehensive_risk_profiler][:score_cache])
      comprehensive_risk_profiler.save(:validate => false)
    else
      user.create_comprehensive_risk_profiler(attributes[:comprehensive_risk_profiler])
    end
  end

  def add_referral_step
    referrer = User.find attributes[:referrer_id]
    PointTracker::ReferralStep.new(referrer).save(:referred_user_id => user.id)
  end

  def is_quiz_skipped?
    attributes[:comprehensive_risk_profiler].present? && attributes[:comprehensive_risk_profiler][:score_cache].present?
  end

  def new_referral?
    attributes[:referrer_id] && !user.already_referred?
  end
end