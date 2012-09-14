require OmniauthSingleSignon::Engine.root.join('app', 'models', 'user')

class User < ActiveRecord::Base
  has_many :completed_steps

  has_many :portfolios, :dependent => :destroy

  has_many :subscriptions, :dependent => :destroy
  has_many :followers, :dependent => :destroy,
           :as => :subscribable, :class_name => 'Subscription'
  has_many :events, :dependent => :destroy

  has_one :comprehensive_risk_profiler, :dependent => :destroy

  has_one :trade_account

  def slug_name
    email.split('@').first
  end

  def has_comprehensive_risk_profiler?
    comprehensive_risk_profiler.persisted?
  end

  def comprehensive_risk_profiler
    super || build_comprehensive_risk_profiler
  end

  def already_referred?
    CompletedStep.where("meta_data -> 'referred_user_id' = '#{self.id}'").present?
  end

  def ebola_points
    PointTracker::Steps().inject(0) do |result, step|
      step_obj = PointTracker::Find(step).new(self)
      result += step_obj.total_points
    end
  end

  def ideal_investment_presenter(initial_investment)
    financial_planner = FinancialPlanner.new(comprehensive_risk_profiler.score)
    amount = initial_investment || comprehensive_risk_profiler.initial_investment
    ideal_investment_mix = IdealInvestmentMix.new(financial_planner, amount)

    IdealInvestmentPresenter.new(ideal_investment_mix, comprehensive_risk_profiler)
  end

end
