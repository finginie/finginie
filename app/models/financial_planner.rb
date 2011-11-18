class FinancialPlanner < ActiveRecord::Base
  belongs_to :user
  has_many :risk_profilers

  validates :willingness_to_take_risk, :numericality => true

  before_validation :set_willingness

  ASSET_ALLOCATION = {
    1 => {
          'Govt Securities' => 70, 'Corporate Bonds' => 10, 'Cash' => 20, 'Large Cap Stocks' => 0,
          'Mid Cap Stocks' => 0, 'International Stocks' => 0, 'Gold' => 0, 'Other Commodities' => 0
    },
    2 => {
          'Govt Securities' => 35, 'Corporate Bonds' => 20, 'Cash' => 15, 'Large Cap Stocks' => 15,
          'Mid Cap Stocks' => 0, 'International Stocks' => 0, 'Gold' => 10, 'Other Commodities' => 0
    },
    3 => {
          'Govt Securities' => 30, 'Corporate Bonds' => 20, 'Cash' => 20, 'Large Cap Stocks' => 20,
          'Mid Cap Stocks' => 0, 'International Stocks' => 0, 'Gold' => 10, 'Other Commodities' => 0
    },
    4 => {
          'Govt Securities' => 20, 'Corporate Bonds' => 25, 'Cash' => 20, 'Large Cap Stocks' => 20,
          'Mid Cap Stocks' => 5, 'International Stocks' => 0, 'Gold' => 10, 'Other Commodities' => 0
    },
    5 => {
          'Govt Securities' => 20, 'Corporate Bonds' => 20, 'Cash' => 15, 'Large Cap Stocks' => 25,
          'Mid Cap Stocks' => 10, 'International Stocks' => 0, 'Gold' => 10, 'Other Commodities' => 0
    },
    6 => {
          'Govt Securities' => 15, 'Corporate Bonds' => 15, 'Cash' => 15, 'Large Cap Stocks' => 30,
          'Mid Cap Stocks' => 10, 'International Stocks' => 5, 'Gold' => 10, 'Other Commodities' => 0
    },
    7 => {
          'Govt Securities' => 15, 'Corporate Bonds' => 10, 'Cash' => 15, 'Large Cap Stocks' => 30,
          'Mid Cap Stocks' => 20, 'International Stocks' => 5, 'Gold' => 5, 'Other Commodities' => 5
    },
    8 => {
          'Govt Securities' => 10, 'Corporate Bonds' => 10, 'Cash' => 15, 'Large Cap Stocks' => 30,
          'Mid Cap Stocks' => 20, 'International Stocks' => 5, 'Gold' => 5, 'Other Commodities' => 5
    },
    9 => {
          'Govt Securities' => 0, 'Corporate Bonds' => 10, 'Cash' => 10, 'Large Cap Stocks' => 25,
          'Mid Cap Stocks' => 30, 'International Stocks' => 10, 'Gold' => 5, 'Other Commodities' => 10
    },
    10 => {
           'Govt Securities' => 0, 'Corporate Bonds' => 0, 'Cash' => 10, 'Large Cap Stocks' => 25,
           'Mid Cap Stocks' => 35, 'International Stocks' => 10, 'Gold' => 5, 'Other Commodities' => 15
    }
  }

  def build_risk_profilers
    quizzes = Quiz.all
    (quizzes-risk_profilers.map{|r| r.quiz}).each {|quiz| risk_profilers.build :quiz => quiz}
    self
  end

  def get_asset_allocation
    ASSET_ALLOCATION[[overall_risk_tolerance.round,willingness_to_take_risk.round].min] if overall_risk_tolerance
  end

  def overall_risk_tolerance
    profilers = risk_profilers.delete_if{ |r| r.score.nil?}
    profilers.map{|r| r.score*r.quiz.weight}.inject(:+)/profilers.sum{|r| r.quiz.weight} if profilers.length > 0 && profilers.length == Quiz.all.length
  end

private
  def set_willingness
    self.willingness_to_take_risk ||= 10
  end
end
