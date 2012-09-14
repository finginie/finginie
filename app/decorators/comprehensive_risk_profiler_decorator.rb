class ComprehensiveRiskProfilerDecorator < ApplicationDecorator
  SUMMARY_CONFIG = {
    :initial_investment           => { private: true },
    :three_month_investment       => { private: true },
    :score_view                   => { private: false },
    :age                          => { private: false },
    :inadequate_household_income  => { private: true },
    :inadequate_household_savings => { private: true },
    :special_goals                => { private: false },
    :time_horizon                 => { private: false },
    :general                      => { private: false }
  }

  decorates :comprehensive_risk_profiler
  include Draper::LazyHelpers
  include NumberHelper

  def alert_message
    h.content_tag :div, :class => 'alert alert-notice' do
      quiz_link = h.link_to 'Click Here', edit_comprehensive_risk_profiler_path
      I18n.t('.comprehensive_risk_profilers.public.personalize_message', :email => user.email, :quiz_link => quiz_link).html_safe
    end
  end

  def skip_quiz_link
    params = { :comprehensive_risk_profiler => { :score_cache => ComprehensiveRiskProfiler::DEFAULT_SCORE } }
    link_to(
      "Skip Step and load balanced portfolio (Not Recommended)",
      comprehensive_risk_profiler_path(params),
      :html_options => { :id => "skip_quiz" },
      :method => :put
    )
  end

  def three_month_household_expenditure
    model.household_expenditure * 3
  end

  def three_month_investment_amount
    model.monthly_savings * 3
  end

  def summary(is_public_financial_profile)
    markup = ActiveSupport::SafeBuffer.new

    SUMMARY_CONFIG.each do |message_summary_key, options_hash|
      next if is_public_financial_profile && options_hash[:private]

      if is_public_financial_profile
        li_tag_value = send("#{message_summary_key}_summary", "public")
      else
        li_tag_value = send("#{message_summary_key}_summary")
      end

      next if li_tag_value.nil?
      markup +=  content_tag(:li, li_tag_value, :data => {:role => message_summary_key})
    end

    markup
  end

  def private_summary
    summary(false)
  end

  def public_summary
    summary(true)
  end

  def age_summary(summary_type = 'private')
    label = case model.age
    when 0..34
      'below_thirty_five'
    when 35..49
      'below_fifty'
    else
      'above_fifty'
    end
    h.t("#{summary_type}.age_summary.#{label}")
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
    model.household_savings < three_month_household_expenditure
  end

  def time_horizon_summary(summary_type = 'private')
    label = case model.time_horizon
    when 0..2
      'below_three_years'
    when 3..4
      'below_five_years'
    else
      'above_five_years'
    end

    translation_key = "#{summary_type}.time_horizon_summary.#{label}"
    h.t "#{translation_key}", :time_horizon_years => time_horizon
  end

  def score_view_summary(summary_type = 'private')
    label = case model.score
    when 0..3
      'below_three'
    when 4..5
      'below_five'
    when 6..8
      'below_eight'
    else
      'above_eight'
    end

    h.t("#{summary_type}.score_summary.#{label}")
  end

  def general_summary(summary_type = 'private')
    h.t("#{summary_type}.general_summary")
  end

  def three_month_investment_summary
    h.t('three_month_investment', :three_month_investment_amount => three_month_investment_amount) unless inadequate_monthly_savings?
  end

  def initial_investment_summary
    h.t("initial_investment", :initial_investment_amount => initial_investment)
  end

  def special_goals_summary(summary_type = 'private')
    h.t "#{summary_type}.special_goals_summary.condition_#{(model.special_goals_factor <= model.monthly_savings).to_s}", :monthly_savings_needed => monthly_savings_needed  if special_goals?
  end

  def inadequate_household_income_summary
    h.t "household_savings_summary.inadequate_household_income"  if inadequate_monthly_savings?
  end

  def inadequate_household_savings_summary
    h.t "household_savings_summary.inadequate_household_savings", :household_savings_less_amount => three_month_household_expenditure  if inadequate_household_savings?
  end

end
