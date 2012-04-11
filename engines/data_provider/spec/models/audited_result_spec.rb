require 'spec_helper'

describe AuditedResult, :mongoid do
  let(:company) { create :company }
  let(:audited_result) { create :audited_result, :companycode => company.company_code,
                                :equity_capital             => "6349990000",
                                :share_appl_money           => "233333",
                                :pref_capital               => "2444444",
                                :resand_surplus             => "643510442000",
                                :revaluation_reserve        => "33333333333",
                                :long_term_loan             => "111111111",
                                :unsecured_term_loans       => "121223344",
                                :unsecured_loans            => "123423444",
                                :borrowings_by_bank         => "2342345321",
                                :cash_credits               => "3398253341000",
                                :bills_purchased            => "517157819000",
                                :term_loans                 => "3651783320000",
                                :net_block                  => "44319588000",
                                :capital_wip                => "3322305000",
                                :net_current_assets         => "-614705428000",
                                :misc_exp_not_w_off         => "122434",
                                :investments                => "2956005690000",
                                :cash_credits               => "3398253341000",
                                :bills_purchased            => "517157819000",
                                :term_loans                 => "3651783320000",
                                :cash_and_bank_balance      => "943955020000",
                                :money_at_call_short_notice => "284786457000",
                                :raw_inventory              => "1753000000",
                                :wip_inventory              => "262000000",
                                :finished_goods_inventory   => "3285000000",
                                :other_inventory            => "172800000",
                                :excise                     => "9347100000",
                                :operating_income           => "955255776000",
                                :other_recurring_income     => "10651411000",
                                :non_recurring_income       => "912682000",
                                :adjusted_pbdit             => "17282385200",
                                :financial_expences         => "4886795610",
                                :extr_ordinary_items        => "-894171300",
                                :layoffretrench_vrs         => "0",
                                :insuranceclaims            => "926200000",
                                :reported_net_profit        => "82645190000",
                                :numberof_equity_shares     => "634998991"

  }
  subject { audited_result }
  before (:each) do
    company.save
    audited_result.save
  end

  it "should calculate the correct total_share_capital " do
    audited_result.total_share_capital.to_i.should eq 6352667777
  end

  describe "for non-banking sector" do
    it "should calculate the net_worth" do
      audited_result.net_worth.to_i.should eq 683196443110
    end

    it "should calculate total debt " do
      audited_result.total_debt.to_i.should eq 232334455
    end

    it "should calculate total liabilites" do
      audited_result.total_liabilities.to_i.should eq 683428777565
    end

    it "should calculate total assets" do
      audited_result.total_assets.to_i.should eq 2388942277434
    end

    it "should calculate inventory" do
      audited_result.inventory.to_i.should eq 5472800000
    end

    it "should calculate sales" do
      audited_result.sales.to_i.should eq 964602876000
    end

    it "should calculate other_income" do
      audited_result.other_income.to_i.should eq 11564093000
    end

    it "should calculate total_income" do
      audited_result.total_income.to_i.should eq 966819869000
    end

    it "should calculate pbdt" do
      audited_result.pbdt.to_i.should eq 12395589590
    end

    it "should calcualte extra_ordinary_items" do
      audited_result.extra_ordinary_items.to_i.should eq 32028700
    end

    it "should calculate earnings_per_share" do
      audited_result.earnings_per_share.to_f.should eq 130.15
    end
  end

  describe "for banking sector" do
    before(:all) { company.update_attribute(:major_sector, 2) }

    it "should calculate the networth for banking sector" do
      audited_result.net_worth.to_i.should eq 649863109777
    end

    it "should calculate total liabilites" do
      audited_result.total_liabilities.to_i.should eq 652328878542
    end

    it "should calculate advances" do
      audited_result.advances.to_i.should eq 7567194480000
    end

    it "should calculate total assets" do
      audited_result.total_assets.to_i.should eq 11184878234434
    end
  end


end
