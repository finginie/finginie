class FinancialPlanner

  IDEAL_ASSET_ALLOCATION = {
    1 => { 'Fixed Deposits' => 100,  'Large Cap Stocks' => 0,   'Mid Cap Stocks' => 0,  'Gold' => 0  },

    2 => { 'Fixed Deposits' => 100,  'Large Cap Stocks' => 0,   'Mid Cap Stocks' => 0,  'Gold' => 0  },

    3 => { 'Fixed Deposits' => 80,   'Large Cap Stocks' => 0,   'Mid Cap Stocks' => 0,  'Gold' => 20 },

    4 => { 'Fixed Deposits' => 60,   'Large Cap Stocks' => 15,  'Mid Cap Stocks' => 0,  'Gold' => 25 },

    5 => { 'Fixed Deposits' => 50,   'Large Cap Stocks' => 25,  'Mid Cap Stocks' => 0,  'Gold' => 25 },

    6 => { 'Fixed Deposits' => 40,   'Large Cap Stocks' => 20,  'Mid Cap Stocks' => 10, 'Gold' => 30 },

    7 => { 'Fixed Deposits' => 35,   'Large Cap Stocks' => 20,  'Mid Cap Stocks' => 15, 'Gold' => 30 },

    8 => { 'Fixed Deposits' => 30,   'Large Cap Stocks' => 20,  'Mid Cap Stocks' => 20, 'Gold' => 30 },

    9 => { 'Fixed Deposits' => 20,   'Large Cap Stocks' => 20,  'Mid Cap Stocks' => 30, 'Gold' => 30 },

    10 => {'Fixed Deposits' => 10,   'Large Cap Stocks' => 15,  'Mid Cap Stocks' => 45, 'Gold' => 30 }
  }

  def self.ideal_asset_allocation(comprehensive_risk_profiler)
    IDEAL_ASSET_ALLOCATION[comprehensive_risk_profiler.score.round] if comprehensive_risk_profiler.score
  end
end
