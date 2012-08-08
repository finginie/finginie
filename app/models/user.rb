require OmniauthSingleSignon::Engine.root.join('app', 'models', 'user')

class User < ActiveRecord::Base
  has_many :completed_steps

  has_many :portfolios, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  has_many :follows, :dependent => :destroy,
           :as => :subscribable, :class_name => 'Subscription'

  has_one :comprehensive_risk_profiler, :dependent => :destroy

  has_one :trade_account

  def has_no_comprehensive_risk_profiler?
    !comprehensive_risk_profiler.persisted?
  end

  def comprehensive_risk_profiler
    super || build_comprehensive_risk_profiler
  end

  def already_referred?
    CompletedStep.where("meta_data -> 'referred_user_id' = '#{self.id}'").present?
  end

  def ebola_points
    total_points = 0
    PointTracker.steps.each do |step|
      pt_obj = "PointTracker::#{step.to_s.classify}".constantize.new(self)
      total_points += pt_obj.total_points
    end
  end

end