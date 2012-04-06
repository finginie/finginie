class RenamedFieldsInAssetManagementCompanyAndScheme < Mongoid::Migration
  def self.up
    Scheme.all.each do |s|
      s.rename( :minimum_invement_amount, :minimum_investment_amount)
      s.rename( :amc_code,                :asset_management_company_code )
      s.rename( :redemption_ferq,         :redemption_frequency)
      s.rename( :prev1_week_per,          :prev1_week_percent )
      s.rename( :prev1_month_per,         :prev1_month_percent )
      s.rename( :prev3_months_per,        :prev3_months_percent )
      s.rename( :prev6_months_per,        :prev6_months_percent )
      s.rename( :prev9_months_per,        :prev9_months_percent )
      s.rename( :prev_year_per,           :prev_year_percent )
      s.rename( :prev2_year_per,          :prev2_year_percent )
      s.rename( :prev2_year_comp_per,     :prev2_year_comp_percent )
      s.rename( :prev3_year_per,          :prev3_year_percent )
      s.rename( :prev3_year_comp_per,     :prev3_year_comp_percent )
    end

    AssetManagementCompany.all.each do |a|
      a.rename( :amc_code,     :asset_management_company_code )
      a.rename( :amc_name,     :asset_management_company_name )
      a.rename( :amc_inc_date, :asset_management_company_incorporation_date )
    end
  end

  def self.down
    Scheme.all.each do |s|
      s.rename( :minimum_investment_amount,     :minimum_invement_amount)
      s.rename( :asset_management_company_code, :amc_code )
      s.rename( :redemption_frequency,          :redemption_ferq)
      s.rename( :prev1_week_percent,            :prev1_week_per )
      s.rename( :prev1_month_percent,           :prev1_month_per )
      s.rename( :prev3_months_percent,          :prev3_months_per )
      s.rename( :prev6_months_percent,          :prev6_months_per )
      s.rename( :prev9_months_percent,          :prev9_months_per )
      s.rename( :prev_year_percent,             :prev_year_per )
      s.rename( :prev2_year_percent,            :prev2_year_per )
      s.rename( :prev2_year_comp_percent,       :prev2_year_comp_per )
      s.rename( :prev3_year_percent,            :prev3_year_per )
      s.rename( :prev3_year_comp_percent,       :prev3_year_comp_per )
    end

    AssetManagementCompany.all.each do |a|
      a.rename( :asset_management_company_code,               :amc_code )
      a.rename( :asset_management_company_name,               :amc_name )
      a.rename( :asset_management_company_incorporation_date, :amc_inc_date )
    end
  end
end
