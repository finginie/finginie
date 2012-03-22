class AddRateOfRedemptionToFixedDeposit < ActiveRecord::Migration
  class FixedDepositTransaction < ActiveRecord::Base
  end

  def change
    add_column :securities, :rate_of_redemption, :decimal

    FixedDepositTransaction.all.each { |t| t.fixed_deposit.destroy && t.destroy if t.action == "sell" } #delete the wrongly associated data
  end
end
