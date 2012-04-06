class Navcp
  include Mongoid::Document

  field :ticker
  field :datetime, :type => DateTime
  field :nav_amount, :type => BigDecimal
  field :repurchase_load, :type => Integer
  field :repurchase_price, :type => BigDecimal
  field :sale_load, :type => Integer
  field :sale_price, :type => BigDecimal
  field :prev_nav_amount, :type => BigDecimal
  field :prev_repurchase_price, :type => BigDecimal
  field :prev_sale_price, :type => BigDecimal
  field :percentage_change, :type => Float
  field :prev1_week_amount, :type => BigDecimal
  field :prev1_week_per, :type => Float
  field :prev1_month_amount, :type => BigDecimal
  field :prev1_month_per, :type => Float
  field :prev3_months_amount, :type => BigDecimal
  field :prev3_months_per, :type => Float
  field :prev6_months_amount, :type => BigDecimal
  field :prev6_months_per, :type => Float
  field :prev9_months_amount, :type => BigDecimal
  field :prev9_months_per, :type => Float
  field :prev_year_amount, :type => BigDecimal
  field :prev_year_per, :type => Float
  field :prev2_year_amount, :type => BigDecimal
  field :prev2_year_per, :type => Float
  field :prev2_year_comp_per, :type => Float
  field :prev3_year_amount, :type => BigDecimal
  field :prev3_year_per, :type => Float
  field :prev3_year_comp_per, :type => BigDecimal
  field :list_date, :type => DateTime
  field :list_amount, :type => BigDecimal
  field :list_per, :type => Float
  field :rank, :type => Integer
end
class AddNavcpFieldsToScheme < Mongoid::Migration
  def self.up
    Navcp.all.each do |navcp|
      @scheme = Scheme.where(securitycode: navcp.security_code).first
      if @scheme
        @scheme.update_attributes( :ticker_name           => navcp.ticker,
                                   :datetime              => navcp.datetime,
                                   :nav_amount            => navcp.nav_amount,
                                   :repurchase_load       => navcp.repurchase_load,
                                   :repurchase_price      => navcp.repurchase_price,
                                   :sale_load             => navcp.sale_load,
                                   :sale_price            => navcp.sale_price,
                                   :prev_nav_amount       => navcp.prev_nav_amount,
                                   :prev_repurchase_price => navcp.prev_repurchase_price,
                                   :prev_sale_price       => navcp.prev_sale_price,
                                   :percentage_change     => navcp.percentage_change,
                                   :prev1_week_amount     => navcp.prev1_week_amount,
                                   :prev1_week_percent    => navcp.prev1_week_per,
                                   :prev1_month_amount    => navcp.prev1_month_amount,
                                   :prev1_month_percent   => navcp.prev1_month_per,
                                   :prev3_months_amount   => navcp.prev3_months_amount,
                                   :prev3_months_percent  => navcp.prev3_months_per,
                                   :prev6_months_amount   => navcp.prev6_months_amount,
                                   :prev6_months_percent  => navcp.prev6_months_per,
                                   :prev9_months_amount   => navcp.prev9_months_amount,
                                   :prev9_months_percent  => navcp.prev9_months_per,
                                   :prev_year_amount      => navcp.prev_year_amount,
                                   :prev_year_percent     => navcp.prev_year_per,
                                   :prev2_year_amount     => navcp.prev2_year_amount,
                                   :prev2_year_percent    => navcp.prev2_year_per,
                                   :prev2_year_comp_percent => navcp.prev2_year_comp_per,
                                   :prev3_year_amount     => navcp.prev3_year_amount,
                                   :prev3_year_percent    => navcp.prev3_year_per,
                                   :prev3_year_comp_percent => navcp.prev3_year_comp_per,
                                   :list_date             => navcp.list_date,
                                   :list_amount           => navcp.list_amount,
                                   :list_percent          => navcp.list_per,
                                   :rank                  => navcp.rank )
        navcp.destroy
      end
    end
  end

  def self.down
  end
end
