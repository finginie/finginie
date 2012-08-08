module PointTracker


  def self.Steps
    [
      :financial_profile_quiz_step,
      :referral_step,
      :sign_up_step,
      :share_financial_profile_on_fb_step
    ]
  end

  def self.Find(step)
    "PointTracker::#{step.to_s.classify}".constantize
  end
end