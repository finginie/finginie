class FinancialPlanner

  IDEAL_ASSET_ALLOCATION = {
    1 => {
          'Government Debt' => 100, 'Corporate Debt' => 0, 'Large Cap Stocks' => 0,
          'Mid Cap Stocks' => 0, 'Gold' => 0
    },
    2 => {
          'Government Debt' => 70, 'Corporate Debt' => 30, 'Large Cap Stocks' => 0,
          'Mid Cap Stocks' => 0, 'Gold' => 0
    },
    3 => {
          'Government Debt' => 55, 'Corporate Debt' => 25, 'Large Cap Stocks' => 0,
          'Mid Cap Stocks' => 0, 'Gold' => 20
    },
    4 => {
          'Government Debt' => 40, 'Corporate Debt' => 20, 'Large Cap Stocks' => 15,
          'Mid Cap Stocks' => 0, 'Gold' => 25
    },
    5 => {
          'Government Debt' => 30, 'Corporate Debt' => 20, 'Large Cap Stocks' => 25,
          'Mid Cap Stocks' => 0, 'Gold' => 25
    },
    6 => {
          'Government Debt' => 20, 'Corporate Debt' => 20, 'Large Cap Stocks' => 20,
          'Mid Cap Stocks' => 10, 'Gold' => 30
    },
    7 => {
          'Government Debt' => 15, 'Corporate Debt' => 20, 'Large Cap Stocks' => 20,
          'Mid Cap Stocks' => 15, 'Gold' => 30
    },
    8 => {
          'Government Debt' => 10, 'Corporate Debt' => 20, 'Large Cap Stocks' => 20,
          'Mid Cap Stocks' => 20, 'Gold' => 30
    },
    9 => {
          'Government Debt' => 0, 'Corporate Debt' => 20, 'Large Cap Stocks' => 20,
          'Mid Cap Stocks' => 30, 'Gold' => 30
    },
    10 => {
           'Government Debt' => 0, 'Corporate Debt' => 10, 'Large Cap Stocks' => 15,
           'Mid Cap Stocks' => 45, 'Gold' => 30
    }
  }

  def self.ideal_asset_allocation(comprehensive_risk_profiler)
    IDEAL_ASSET_ALLOCATION[comprehensive_risk_profiler.score.round] if comprehensive_risk_profiler.score
  end
end
