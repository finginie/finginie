class AddActionToAllTransactionsType < ActiveRecord::Migration
  class MutualFundTransaction < ActiveRecord::Base
  end

  class StockTransaction < ActiveRecord::Base
  end

  class GoldTransaction < ActiveRecord::Base
  end

  class FixedDepositTransaction < ActiveRecord::Base
  end

  class LoanTransaction < ActiveRecord::Base
  end

  class RealEstateTransaction < ActiveRecord::Base
  end

  def change
    add_column :mutual_fund_transactions, :action, :string
    add_column :stock_transactions, :action, :string
    add_column :gold_transactions, :action, :string
    add_column :fixed_deposit_transactions, :action, :string
    add_column :loan_transactions, :action, :string
    add_column :real_estate_transactions, :action, :string

    MutualFundTransaction.all.each     { |t| t.quantity >= 0 ? t.update_attributes(:action => "buy", :quantity => t.quantity.abs) : t.update_attributes(:action => "sell", :quantity => t.quantity.abs) }
    StockTransaction.all.each          { |t| t.quantity >= 0 ? t.update_attributes(:action => "buy", :quantity => t.quantity.abs) : t.update_attributes(:action => "sell", :quantity => t.quantity.abs) }
    GoldTransaction.all.each           { |t| t.quantity >= 0 ? t.update_attributes(:action => "buy", :quantity => t.quantity.abs) : t.update_attributes(:action => "sell", :quantity => t.quantity.abs) }
    FixedDepositTransaction.all.each   { |t| t.price >= 0 ? t.update_attributes(:action => "buy", :price => t.price.abs) : t.update_attributes(:action => "sell", :price => t.price.abs) }
    LoanTransaction.all.each           { |t| t.price >= 0 ? t.update_attributes(:action => "buy", :price => t.price.abs) : t.update_attributes(:action => "sell", :price => t.price.abs) }
    RealEstateTransaction.all.each     { |t| t.price >= 0 ? t.update_attributes(:action => "buy", :price => t.price.abs) : t.update_attributes(:action => "sell", :price => t.price.abs) }
  end
end
