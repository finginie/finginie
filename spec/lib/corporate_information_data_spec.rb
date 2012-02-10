require 'spec_helper'
require 'vcr'

describe CorporateInformationData do
  before(:all) do
    VCR.use_cassette("corporate_info_parsing") do
      Timecop.freeze(Time.parse("2011-12-27 23:00:00 +530")) do
        CorporateInformationData.update_data
      end
    end
  end

  it "should have a AnnouncementsAGMBC record" do
    AnnouncementsAgmbc.exists?( conditions: { company_code: "11080023" , date_of_announcement: Date.parse("26/12/2011"), source_code: 584 } ).should be_true
  end

  it "should have a AnnouncementsBoardMeeting record" do
    AnnouncementsBoardMeeting.exists?( conditions: { company_code: "13190059", brd_date: Date.parse("02/09/2011"), src_code: 584 } ).should be_true
  end

  it "should have a Audited Result Record" do
    AuditedResult.exists?(conditions: { companycode: "11150001",
                                        year_ending: "30/06/2011",
                                        admin_expenses: "55236074",
                                        imp_capital_goods: "43005000",
                                        cash_and_bank_balance: "5313593" } ).should be_true
  end

  it "should have a BsePrice record" do
    BsePrice.exists?( conditions: { security_code: "017023928.00026005032", price_date: "27/12/2011", close_price: 16.43 } ).should be_true
  end

  it "should have a Capitalstructure record" do
    Capitalstructure.exists?( conditions: { company_code: "11040100", modifyon: "27 Nov 2007 16:55:50" } ).should be_true
  end

  it "should have a CompanyMaster record" do
    CompanyMaster.exists?( conditions: { company_code: "14056853", product_status_code: "2161" } ).should be_true
  end

  it "should have a CorpGovernancereport record" do
    CorpGovernancereport.exists?( conditions: { company_code: "10560013", year_ending: "31/03/2010" } ).should be_true
  end

  it "should have a HalfyearlyResults record" do
    record = HalfyearlyResult.where( company_code: "16040001",
                                    year_ending: "30/09/2010",
                                    months: 6,
                                    half: 1 ).first
    record.gross_profit.should eq -820000
    record.employee_expenses.should eq 1797000
  end

  it "should have a IndividualHolding record" do
    IndividualHolding.exists?( conditions: { company_code: "15210030",
                                             share_holding_date: "06/10/2010" } ).should be_true
  end

  it "should have a IndustryMaster record" do
    IndustryMaster.exists?( conditions: { industry_code: 162, broad_industry_code: 21, major_sector_code: 390, major_sector_name: "General" } ).should be_true
  end

  it "should have a KeyExecutive record" do
    KeyExecutive.exists?( conditions: { company_code: "16010026",
                                        modifyon: "27/12/2011 11:59" } ).should be_true

  end

  it "should have a MFdividendDetail record" do
    record = MfDividendDetail.where( securitycode: "14055408.002184",
                              dividend_date: "23/12/2011").first
    record.dividend_type.should eq 2075
    record.percentage.should eq 0.0204
  end

  it "should have a MFNAVDetail record" do
    MfnavDetail.exists?( conditions: { security_code: "14051526.002199",
                                       nav_date: "26/12/2011",
                                       nav_amount: 8.62,
                                       repurchase_price: 8.53 } ).should be_true
  end

  it "should have a MFObjective record" do
    record = MfObjective.where( securitycode: "14056853.002067" ).first
    record.objective.should eq "The Investment objective of the Scheme would be to achieve growth of capital through investments made in a basket of debt/ fixed income securities maturing on or before the maturity of the Scheme."
  end

  it "should have a MFRollingReturn Record" do
    MfRollingReturn.exists?( conditions: { security_code: "17024533.002066",
                                            nav_amount: "1000",
                                            two_weeks_return: "0",
                                            sale_price: "1000" } ).should be_true
  end

  it "should have a MFSchemewisePortfolio record" do
    record = MfSchemeWisePortfolio.where( security_code: "14056020.002067", holding_date: "31/10/2011" )
    record.first.element[0]["PortfolioUOM"].to_f.should eq 838
    record.first.element[0]["InvestedCompanyName"].should eq "Net Current Assets/(Liabillties)"
    record.first.element[0]["MarketValue"].to_f.should eq 0.0577
  end

  it "should have a NavCategoryDetail record" do
    NavCategoryDetail.exists?( conditions: { scheme_class_code: "2402",
                                              scheme_class_description: "Special Fund",
                                              no_of_schemes: 28,
                                              one_month_return: "-1.8167",
                                              three_year_return: "42.8163" } ).should be_true
  end

  it "should have a Navcp record" do
    Navcp.exists?( conditions: { security_code: "17024533.002066",
                                  ticker: "GoldmanS Liquid BeES (G)",
                                  nav_amount: "1000",
                                  prev1_week_per: 0.0,
                                  prev3_year_per: 0.0,
                                  prev9_months_amount: "1000",
                                  prev3_months_per: 0.0 } ).should be_true
  end

  it "should have a NavMaster record" do
    NavMaster.exists?( conditions: { security_code: "14056842.002066",
                                      scheme_code: "14056842",
                                      mapping_code: "116341",
                                      bench_mark_index: "014010005.00026005005",
                                      bench_mark_index_name: "Crisil Short-Term Bond Fund Index" } ).should be_true
  end

  it "should have a NavMonthlyDetail record " do
    NavMonthlyDetail.exists?( conditions: { security_code: "17024533.002066",
                                           nav_date: "26/12/2011",
                                           open_nav: 1000.0,
                                           high_nav: 1000.0,
                                           low_date: "01/12/2011",
                                           close_date: "26/12/2011" } ).should be_true
  end

  it "should have a NavQuarterlyDetail record" do
    NavQuarterlyDetail.exists?( conditions: { security_code: "17024533.002066",
                                               year_end: "2011",
                                               q1_open_nav: 1000,
                                               ann_close_nav: 1000 } ).should be_true
  end

  it "should have a NavWeeklyDetail record" do
    NavWeeklyDetail.exists?( conditions: { security_code: "17024533.002066",
                                            nav_date: "26/12/2011",
                                            open_nav: 1000.0,
                                            close_nav: 1000.0,
                                            high_date: "26/12/2011" } ).should be_true
  end

  it "should have a News record" do
    News.exists?( conditions: { company_code: "99999999",
                                 news_date: "27/12/2011",
                                 headlines: "Wilmar shelves its China IPO plans",
                                 source_name: "Religare Technova" } ).should be_true
  end

  it "should have a NinemonthsResult record" do
    NinemonthsResult.exists?( conditions: { company_code: "15210030",
                                             year_ending: "31/12/2010",
                                             months: 9,
                                             nine: 1,
                                             operating_income: "17192059000",
                                             equity_capital: "571978000",
                                             eps: 16.584 } ).should be_true
  end

  it "should have a NsePrice record" do
    NsePrice.exists?( conditions: { security_code: "017110005.00005004001",
                                     price_date: "27/12/2011",
                                     high_price: 126.0,
                                     close_price: 125.05,
                                     traded_value: 53108.45,
                                     traded_quantity: 425 } ).should be_true
  end

  it "should have a Product record" do
    record = Product.where( company_code: "16570006", year_ending: "31/03/2011", no_of_months: 12 ).first
    record.element[0]["ProductCode"].should eq "660100.0001"
    record.element[0]["OpeningValue"].should eq "26625"
    record.element[0]["ProductName"].should eq "Umbrellas"
  end

  it "should have a QuarterlyResult record" do
    record = QuarterlyResult.where( company_code: "16040001",
                                           year_ending: "30/09/2011",
                                           months: 3,
                                           quarter: 2 ).first
    record.operating_income.to_i.should eq 19552000
    record.gross_profit.to_i.should eq 2753000
    record.reported_pat.to_i.should eq 2503000
  end

  it "should have a Ratio record" do
    record = Ratio.where( company_code: "16610077",
                                year_ending: "31/03/2011",
                                months: 12,
                                adjusted_eps: "0.1388",
                                long_term_assets: "0.3929",
                                net_profit_margin: "-0.84",
                                operating_cash_flow_to_sales_ratio: "-1.1425" )
    record.first.type.should eq "A"
  end

  it "should have a Rawmaterial record" do
    raw_material = Rawmaterial.where( company_code: "16010026", year_ending: "31/03/2011" )
    raw_material.first.element["ProductCode"].to_f.should eq 999999.1224
    raw_material.first.element["ProdMix"].to_f.should eq 100
  end

  it "should have a SchemeMaster record" do
    SchemeMaster.exists?( conditions: { securitycode: "14055923.002067",
                                      company_code: "14051871",
                                      scheme_type_description: "Open Ended",
                                      initial_price_uom: 763,
                                      fund_manager_name: "Shriram Ramanathan",
                                      product_code: "FFSID",
                                      sip: "True" } ).should be_true
  end

  it "should have a ShareHolding record" do
    share_holding = ShareHolding.where( company_code: "17020001", share_holding_date: "30/09/2011" )
    share_holding.first.element[0]["NoOfShareHolders"].to_i.should eq 5727
    share_holding.first.element[0]["DistinctiveNumbers"].should eq "1 to 8700000"
    share_holding.first.element[0]["EquityShareHold"].to_i.should eq 750000
  end

  it "should have a Subsidiary record" do
    Subsidiary.exists?( conditions: { company_code: "15140089", company_name: "MIC Electronics Inc. USA", parent_company_code: "15140079" } ).should be_true
  end
end
