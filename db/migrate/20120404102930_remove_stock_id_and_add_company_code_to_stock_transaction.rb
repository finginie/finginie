class RemoveStockIdAndAddCompanyCodeToStockTransaction < ActiveRecord::Migration
  class StockTransaction < ActiveRecord::Base
  end

  class Security < ActiveRecord::Base
  end

  class Company
    include Mongoid::Document
  end

  def self.up
    add_column :stock_transactions, :company_code, :decimal

    StockTransaction.all.each do |s|
      company = Company.where( nse_code: Security.find(s.stock_id).symbol ).first
      s.update_attributes( :company_code => company.company_code ) if company
    end

    remove_column :stock_transactions, :stock_id, :integer
  end

  def self.down
    add_column :stock_transactions, :stock_id, :integer
    StockTransaction.all.each do |s|
      company = s.company_code ? Company.where( company_code: s.company_code).first : nil
      if company
        stock = Stock.find_by_symbol(company.nse_code)
        s.update_attributes( :stock_id => stock.id )
      end
    end

    remove_column :stock_transactions, :company_code, :decimal
  end

end
