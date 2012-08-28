module PointTracker
  class ReferralStep < Base
    DESCRIPTION = 'Every sign up from shared link'
    ACTION_LINK = '/comprehensive_risk_profiler/ideal_investments'
    POINTS      = 200

    def valid?
      !(referred_himself? || already_referred?)
    end

    private
    def already_referred?
      referred_user.already_referred?
    end

    def referred_himself?
      referred_user.id == user.id
    end

    def referred_user
      User.find meta_data[:referred_user_id]
    end
  end
end