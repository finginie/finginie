class AddRateOfRedemptionToFixedDeposit < ActiveRecord::Migration
  def change
    add_column :securities, :rate_of_redemption, :decimal
  end
end
