module PointTracker
  class ReferralStep < Base
    DESCRIPTION = 'Every sign up from shared link'
    ACTION_LINK = '/comprehensive_risk_profiler/ideal_investments'
    POINTS      = 200

    def save(meta_data = {})
      super unless referred_himself?(meta_data[:referred_user_id])
    end

    private
    def referred_himself?(referred_user_id)
      referred_user_id == user.id
    end
  end
end