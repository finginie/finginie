require 'kaminari'
require 'kaminari/models/mongoid_extension'

module SchemeExtensions
  extend ActiveSupport::Concern

  TOP_GOLD_ETFS = [
    'Goldman Sachs Gold Exchange Traded Scheme-Growth',
    'SBI Gold Exchange Traded Scheme-Growth',
    'Kotak Gold ETF-Growth'
  ]
  LARGE_CAP_INDICES = ["BSE 100 Index", "S&P CNX 500 Equity Index", "NSE Index", "NSE CNX 100"]
  MID_CAP_INDICES   = ["CNX Midcap Index", "BSE Mid-Cap Index"]

  included do
    scope :top_gold_etfs, where(:name.in => TOP_GOLD_ETFS)
    scope :viable_indices, lambda { |indices_array|
      only(:code, :name, :plan_code, :minimum_investment_amount, :size, :entry_load, :exit_load, :prev3_year_comp_percent).
      where(:bench_mark_index_name.in => indices_array).
      where(:minimum_investment_amount.lte => 5000, :size.gte => 50)
    }
    scope :elss_funds, where(:class_code => 2119)
    scope :order_by_prev3_year_comp_percent, order_by(:prev3_year_comp_percent => :desc)
  end

  module ClassMethods
    def top_mid_cap_stocks(limit)
      mid_cap_schemes = get_indices_with_min_entry_and_exit_load(MID_CAP_INDICES).take(3 * limit)
      distinct_schemes(mid_cap_schemes).take(limit)
    end

    def top_large_cap_stocks(limit)
      goldman_sachs_nifty_etf = where(:security_code => "17024319.002066").first
      large_cap_schemes = [
        get_indices_with_min_entry_and_exit_load(LARGE_CAP_INDICES).take(3 * limit),
        goldman_sachs_nifty_etf
      ].flatten.compact.sort_by(&:prev3_year_comp_percent).reverse.take(3 * limit)

      distinct_schemes(large_cap_schemes).take(limit)
    end

    def get_indices_with_min_entry_and_exit_load(indices)
      viable_indices(indices).order_by_prev3_year_comp_percent.select{ |scheme| (scheme.entry_load.to_f + scheme.exit_load.to_f) <= 2 }
    end

    def distinct_schemes(schemes)
      distinct_schemes = schemes.group_by(&:code).values
      growth_plan_code, dividend_plan_code = 2066, 2067
      distinct_schemes.inject([]) do |result, plans|
        grow_plan_schemes     = plans.select{|scheme| scheme.plan_code == growth_plan_code}.first
        dividend_plan_schemes = plans.select{|scheme| scheme.plan_code == dividend_plan_code}.first
        result << (grow_plan_schemes || dividend_plan_schemes)
      end
    end

    def top_gainers(count)
      count ||= 5
      active.equity_funds.order([[ :percentage_change, :desc ]]).limit(count)
    end

    def top_losers(count)
      count ||= 5
      active.equity_funds.where(:percentage_change.lt => 0).order([[ :percentage_change, :asc ]]).limit(count)
    end

    def biggest_funds(count)
      count ||= 5
      active.equity_funds.order([[ :size, :desc ]]).limit(count)
    end
  end
end


DataProvider::Scheme.class_eval do
  include SchemeExtensions
  include Kaminari::MongoidExtension::Criteria
  include Kaminari::MongoidExtension::Document
end
