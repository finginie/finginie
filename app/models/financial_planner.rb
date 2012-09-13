class FinancialPlanner

  attr_reader :score

  IDEAL_ASSET_ALLOCATION_CONFIG = [
    { 'Fixed Deposits' => 100,  'Large Cap Stocks' => 0,   'Mid Cap Stocks' => 0,  'Gold' => 0  }, #score - 1

    { 'Fixed Deposits' => 100,  'Large Cap Stocks' => 0,   'Mid Cap Stocks' => 0,  'Gold' => 0  }, #score - 2

    { 'Fixed Deposits' => 80,   'Large Cap Stocks' => 0,   'Mid Cap Stocks' => 0,  'Gold' => 20 }, #score - 3

    { 'Fixed Deposits' => 60,   'Large Cap Stocks' => 15,  'Mid Cap Stocks' => 0,  'Gold' => 25 }, #score - 4

    { 'Fixed Deposits' => 50,   'Large Cap Stocks' => 25,  'Mid Cap Stocks' => 0,  'Gold' => 25 }, #score - 5

    { 'Fixed Deposits' => 40,   'Large Cap Stocks' => 20,  'Mid Cap Stocks' => 10, 'Gold' => 30 }, #score - 6

    { 'Fixed Deposits' => 35,   'Large Cap Stocks' => 20,  'Mid Cap Stocks' => 15, 'Gold' => 30 }, #score - 7

    { 'Fixed Deposits' => 30,   'Large Cap Stocks' => 20,  'Mid Cap Stocks' => 20, 'Gold' => 30 }, #score - 8

    { 'Fixed Deposits' => 20,   'Large Cap Stocks' => 20,  'Mid Cap Stocks' => 30, 'Gold' => 30 }, #score - 9

    {'Fixed Deposits' => 10,   'Large Cap Stocks' => 15,  'Mid Cap Stocks' => 45, 'Gold' => 30 }   #score - 10
  ]

  ASSET_CLASSES = %w(fixed_deposits large_cap_stocks mid_cap_stocks gold)

  def initialize(score)
    @score = score.round
  end

  ASSET_CLASSES.each do |asset_class|
    method = "#{asset_class}_percent"                      ##
    define_method(method) do                               # def fixed_depoists_percent
      ideal_asset_allocation[asset_class.titleize]         #   ideal_asset_allocation['Fixed Deposits']
    end                                                    # end
  end                                                      ##

  def ideal_asset_allocation
    @ideal_asset_allocation ||= IDEAL_ASSET_ALLOCATION_CONFIG[score - 1]
  end

  # def self.ideal_asset_allocation(comprehensive_risk_profiler)
  #   IDEAL_ASSET_ALLOCATION[comprehensive_risk_profiler.score.round] if comprehensive_risk_profiler.score
  # end
end
