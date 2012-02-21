class MutualFundsController < InheritedResources::Base
  def index
    @mutual_funds = SchemeMaster.all
    index!
  end

  def scheme_summary

  end

  def scheme_returns

  end

  def top_holdings

  end

  def detailed_holdings

  end

  def asset_allocation

  end

  def sectoral_allocation

  end
end
