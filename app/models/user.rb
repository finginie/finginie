require OmniauthSingleSignon::Engine.root.join('app', 'models', 'user')

class User < ActiveRecord::Base
  has_many :portfolios, :dependent => :destroy

  has_many :subscriptions, :dependent => :destroy
  has_many :follows, :dependent => :destroy,
           :as => :subscribable, :class_name => 'Subscription'

  has_one :comprehensive_risk_profiler, :dependent => :destroy
  has_many :completed_steps

  has_one :trade_account

  def merge_comprehensive_risk_profiler(attributes)
    return self if comprehensive_risk_profiler.persisted?
    attributes[:score_cache] ? comprehensive_risk_profiler.update_attribute(:score_cache, attributes[:score_cache]) : create_comprehensive_risk_profiler(attributes)
    self
  end

  def comprehensive_risk_profiler
    super || build_comprehensive_risk_profiler
  end

  def already_referred?
    CompletedStep.where("data -> 'referred_user_id' = '#{self.id}'").present?
  end

  def completed_referral_step?
    completed_steps.where(step_id: Step::REFERRAL).present?
  end
end
