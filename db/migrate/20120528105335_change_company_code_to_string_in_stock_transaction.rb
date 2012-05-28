class ChangeCompanyCodeToStringInStockTransaction < ActiveRecord::Migration
  def change
    change_table(:stock_transactions) do |t|
      t.change :company_code, :string
    end
  end

end
