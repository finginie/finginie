require OmniauthSingleSignon::Engine.root.join('app', 'models', 'user')

class User < ActiveRecord::Base

  has_many :steps, :through => :completed_steps
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
    CompletedStep.where("data -> 'referred_user_id' = '#{self.id}'").present?
  end

  Step.ebola_steps.each do |step|
    check_for_completed_step_method = "completed_#{step}_step?"
    define_method check_for_completed_step_method do
      completed_steps.where(:step_id => Step.const_get(step.upcase)).present?
    end

    completed_step_obj_method = "completed_#{step}_step"
    define_method completed_step_obj_method do
      completed_steps.where(:step_id => Step.const_get(step.upcase)).first
    end

    create_completed_step_method = "finished_#{step}_step"
    define_method create_completed_step_method do |data = {}|
      step_id = Step.const_get(step.upcase)
      CompletedStep.create({ :user_id => id, :step_id => step_id, :data => data })
    end
  end

  def ebola_points
    total_points = 0
    Step.ebola_steps.each do |step|
      method = "completed_#{step}_step?"
      if send(method)
        step_id = Step.const_get step.upcase
        steps_completed_no_of_times = CompletedStep.where(:step_id => step_id, :user_id => self.id).count
        total_points += Step.find(step_id).points * steps_completed_no_of_times
      end
    end

    total_points
  end

end
