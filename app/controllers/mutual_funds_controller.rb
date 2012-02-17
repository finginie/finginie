class MutualFundsController < InheritedResources::Base
  def index
    @mutual_funds = SchemeMaster.all
    index!
  end

  def scheme_summary
    @scheme = SchemeMaster.where( scheme_name: params[:id] ).first
    @scheme = SchemeMasterDecorator.decorate(@scheme)
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
