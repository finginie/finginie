module PointTracker

  def self.Steps
    [
      :financial_profile_quiz_step,
      :referral_step,
      :sign_up_step,
      :share_financial_profile_on_fb_step,
      :share_financial_profile_on_twitter_step,
      :create_portfolio_and_add_transaction_step,
      :share_financial_profile_via_mail_step,
      :share_quiz_details_on_fb_step
    ]
  end

  def self.Find(step)
    "PointTracker::#{step.to_s.classify}".constantize
  end

  def self.add_points_for(params, user)
    step, invited_users = params[:step], params[:contacts]
    step_klass = step.constantize
    invited_users.each do |email|
      meta_data = { :invited_user_mail => email }
      step_klass.new(user, meta_data).save
    end
  end
end
