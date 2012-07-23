class ComprehensiveRiskProfilerDecorator < ApplicationDecorator
  decorates :comprehensive_risk_profiler
  include Draper::LazyHelpers
  include NumberHelper

  def three_month_household_expenditure
    model.household_expenditure * 3
  end

  def initial_investment
    model.initial_investment > 0 ? model.initial_investment : model.household_savings/2
  end

  def three_month_investment_amount
    model.monthly_savings * 3
  end

  def summary
    markup = content_tag(:li, h.t("initial_investment", :initial_investment_amount => initial_investment), :data =>{:role => 'initial_investment'})
    markup +=  content_tag(:li, h.t('three_month_investment', :three_month_investment_amount => three_month_investment_amount), :data =>{:role => 'three_month_investment'}) unless inadequate_monthly_savings?
    markup +=  content_tag(:li, score_view_summary, :data =>{:role => 'score_view_summary'})
    markup +=  content_tag(:li, age_summary, :data =>{:role => 'age_summary'})
    markup +=  content_tag(:li, inadequate_household_income, :data =>{:role => 'household_savings_summary'}) if inadequate_monthly_savings?
    markup +=  content_tag(:li, inadequate_household_savings, :data =>{:role => 'household_savings_summary'}) if inadequate_household_savings?
    markup +=  content_tag(:li, special_goals_summary, :data =>{:role => 'special_goals_summary'}) if special_goals?
    markup +=  content_tag(:li, time_horizon_summary, :data =>{:role => 'time_horizon_summary'})
    markup +=  content_tag(:li, h.t("general_summary"), :data =>{:role => 'general_summary'})
    markup
  end

  def age_summary
    h.t case model.age
      when 0..34
        "age_summary.below_thirty_five"
      when 35..49
        "age_summary.below_fifty"
      else
        "age_summary.above_fifty"
      end
  end

  def score
    model.score.round if model.score
  end

  def monthly_savings_needed
    (model.special_goals_factor - model.monthly_savings)
  end

  def inadequate_monthly_savings?
    monthly_savings <= 0
  end

  def inadequate_household_savings?
    model.household_savings < (model.household_expenditure * 3)
  end

  def time_horizon_summary
    translation_key = case model.time_horizon
      when 0..2
        "time_horizon_summary.below_three_years"
      when 3..4
        "time_horizon_summary.below_five_years"
      else
        "time_horizon_summary.above_five_years"
      end
    h.t "#{translation_key}", :time_horizon_years => time_horizon
  end

  def score_view_summary
    h.t case model.score
      when 0..3
        "score_summary.below_three"
      when 4..5
        "score_summary.below_five"
      when 6..8
        "score_summary.below_eight"
      else
        "score_summary.above_eight"
      end
  end

  def special_goals_summary
    h.t "special_goals_summary.condition_#{(model.special_goals_factor <= model.monthly_savings).to_s}", :monthly_savings_needed => monthly_savings_needed
  end

  def inadequate_household_income
    h.t "household_savings_summary.inadequate_household_income" if inadequate_monthly_savings?
  end

  def inadequate_household_savings
    h.t "household_savings_summary.inadequate_household_savings", :household_savings_less_amount => three_month_household_expenditure if inadequate_household_savings?
  end
end
