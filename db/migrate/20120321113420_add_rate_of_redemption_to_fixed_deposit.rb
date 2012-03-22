class AddRateOfRedemptionToFixedDeposit < ActiveRecord::Migration
  class FixedDepositTransaction < ActiveRecord::Base
  end
  class FixedDeposit < ActiveRecord::Base
  end

  def change
    add_column :securities, :rate_of_redemption, :decimal

    FixedDepositTransaction.all.each { |t| FixedDeposit.find(t.fixed_deposit_id).destroy && t.destroy if t.action == "sell" } #delete the wrongly associated data
  end
end
