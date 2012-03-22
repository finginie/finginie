class ChangeActionDataInLoanTransaction < ActiveRecord::Migration
  class LoanTransaction < ActiveRecord::Base
  end

  def change
    LoanTransaction.all.each { |t| (t.action == "Sell" || t.action == "sell") ? t.update_attributes(:action => "repay") : t.update_attributes(:action => "borrow") }
  end
end
