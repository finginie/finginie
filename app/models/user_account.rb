class UserAccount
  attr_reader :user, :attributes

  def initialize(user)
    @user = user
  end

  def success_callback(session_hash) #Is there a better name we can give for this method?
    @attributes = session_hash

    create_comprehensive_risk_profiler_if_not_persisted
    create_referrer_completed_step_if_referred
    create_sign_up_completed_step
  end

  private
  def create_referrer_completed_step_if_referred
    # session of referrar_id is set and user is not already referred by some other user, this conditional should be moved to a method
    if attributes[:referrer_id] && !user.already_referred?
      referrer = User.find attributes[:referrer_id]
      referrer.finished_referral_step({ :referred_user_id => user.id })
    end
  end

  def create_comprehensive_risk_profiler_if_not_persisted
    save_comprehensive_risk_profiler_from_session if user.has_no_comprehensive_risk_profiler?
  end

  def save_comprehensive_risk_profiler_from_session
    if is_quiz_skipped?
      comprehensive_risk_profiler = user.build_comprehensive_risk_profiler(:score_cache => attributes[:score_cache])
      comprehensive_risk_profiler.save(:validate => false)
    else
      user.create_comprehensive_risk_profiler(attributes[:comprehensive_risk_profiler])
    end
  end

  def create_sign_up_completed_step
    user.finished_sign_up_step unless user.completed_sign_up_step?
  end

  def is_quiz_skipped?
    attributes[:score_cache].present?
  end
end