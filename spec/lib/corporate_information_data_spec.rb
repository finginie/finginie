require 'spec_helper'

describe CorporateInformationData, :mongoid, :vcr do
  let(:corporate_info) {
    corporate_info = nil
    Timecop.freeze(Time.parse("2012-02-10 23:00:00 +530")) do
      corporate_info = CorporateInformationData.new
    end
    corporate_info
  }

  subject { corporate_info }

  it "should have a AccountingPolicy record" do
    subject.parse_and_update("AccountingPolicy.xml")
    AccountingPolicy.exists?( conditions: { company_code: "17020498", year_ending: "31/03/2011" } ).should be_true
  end

  it "should have a AnnouncementsAGMBC record" do
    subject.parse_and_update("AnnouncementsAGMBC.xml")
    AnnouncementsAgmbc.exists?( conditions: { company_code: "11510001", date_of_announcement: Date.parse("09/02/2012"), source_code: 711 } ).should be_true
  end

  it "should have a AnnouncementsBoardMeeting record" do
    subject.parse_and_update("AnnouncementsBoardMeeting.xml")
    AnnouncementsBoardMeeting.exists?( conditions: { company_code: "14040025" , brd_date: Date.parse("25/01/2012"), src_code: 584 } ).should be_true
  end

  it "should have a AuditorsReport record" do
    subject.parse_and_update("AuditorsReport.xml")
    AuditorsReport.exists?( conditions: { company_code: "17020538", year_ending: "31/03/2010" } ).should be_true
  end

  it "should have a Audited Result Record" do
    subject.parse_and_update("AuditedResults.xml")
    AuditedResult.exists?(conditions: { companycode: "11080004",
                                        year_ending: "31/03/2011",
                                        admin_expenses: "94799000",
                                        imported_rawmat: "2299070000",
                                        cash_and_bank_balance: "86741000" } ).should be_true
  end

  it "should have a BsePrice record" do
    subject.parse_and_update("BSEPrice.xml")
    BsePrice.exists?( conditions: { security_code: "017023928.00026005001", price_date: "10/02/2012", close_price: 9304.31 } ).should be_true
  end

  it "should have a Capitalstructure record" do
    subject.parse_and_update("Capitalstructure.xml")
    Capitalstructure.exists?( conditions: { company_code: "11020009", modifyon: "27 Feb 2009 16:14:59" } ).should be_true
  end

  it "should have a CashFlow record" do
    subject.parse_and_update("CashFlow.xml")
    CashFlow.exists?( conditions: { company_code: "16610155", year_ending: "31/03/2011", type: "A", months: 12, pbt: "-247796"  } ).should be_true
  end

  it "should have a CompanyMaster record" do
    subject.parse_and_update("CompanyMaster.xml")
    Company.exists?( conditions: { company_code: "11550030", product_status_code: "1753" } ).should be_true
  end

  it "should have a CorpGovernancereport record" do
    subject.parse_and_update("CorpGovernancereport.xml")
    CorpGovernancereport.exists?( conditions: { company_code: "11610052", year_ending: "31/03/2011" } ).should be_true
  end

  it "should have a DirectorsReport record" do
    subject.parse_and_update("DirectorsReport.xml")
    DirectorsReport.exists?( conditions: { company_code: "14010016", year_ending: "31/03/2011" } ).should be_true
  end

  it "should have a Dividend record" do
    subject.parse_and_update("Dividend.xml")
    Dividend.exists?( conditions: { company_code: "11510001", date_of_announcement: "09/02/2012", percentage: "170" } ).should be_true
  end

  it "should have a HalfyearlyResults record" do
    subject.parse_and_update("HalfyearlyResults.xml")
    HalfyearlyResult.exists?( conditions: { company_code: "10680017",
                                            year_ending: "31/12/2011",
                                            months: 6,
                                            half: 1,
                                            gross_profit: "3011000",
                                            employee_expenses: "354000"} ).should be_true
  end

  it "should have a IndividualHolding record" do
    subject.parse_and_update("IndividualHolding.xml")
    IndividualHolding.exists?( conditions: { company_code: "10650004",
                                             share_holding_date: "31/12/2011" } ).should be_true
  end

  # it "should have a IndustryMaster record" do
  #    subject.parse_and_update("IndustryMaster.xml")
  #    IndustryMaster.exists?( conditions: { industry_code: 162, broad_industry_code: 21, major_sector_code: 390, major_sector_name: "General" } ).should be_true
  #  end

  it "should have a KeyExecutive record" do
    subject.parse_and_update("KeyExecutives.xml")
    KeyExecutive.exists?( conditions: { company_code: "11020009",
                                        modifyon: "10/02/2012 11:21" } ).should be_true

  end

  it "should have a MFdividendDetail record" do
    subject.parse_and_update("MFDividendDetails.xml")
    MfDividendDetail.exists?( conditions: { securitycode: "14050439.002067",
                                            dividend_date: "15/02/2012",
                                            dividend_type: "2073",
                                            percentage: "30" } ).should be_true
  end

  it "should have a MFNAVDetail record" do
    subject.parse_and_update("MFNAVDetails.xml")
    MfnavDetail.exists?( conditions: { security_code: "14050079.002066",
                                       nav_date: "09/02/2012",
                                       nav_amount: "256.6661",
                                       repurchase_price: "256.6661" } ).should be_true
  end

  it "should have a MFObjective record" do
    subject.parse_and_update("MFObjectives.xml")
    record = MfObjective.where( securitycode: "14051233.002199" ).first
    record.objective.should eq "An open-ended equity scheme with the objective to generate long-term capital growth from investment in a diversified portfolio of equity and equity related securities."
  end

  it "should have a MFRollingReturn Record" do
    subject.parse_and_update("MFRollingReturn.xml")
    MfRollingReturn.exists?( conditions: { security_code: "14050001.052066",
                                           nav_amount: "52.4",
                                           two_weeks_return: "3.8241",
                                           sale_price: "52.4" } ).should be_true
  end

  it "should have a MFSchemewisePortfolio record" do
    subject.parse_and_update("MFSchemeWisePortfolio.xml")
    record = MfSchemeWisePortfolio.where( security_code: "14050284.002066", holding_date: "31/01/2012" )
    record.first.element.first["PortfolioUOM"].to_f.should eq 838
    record.first.element.first["InvestedCompanyName"].should eq "Cash and other assets"
    record.first.element.first["MarketValue"].to_f.should eq 56.529
  end

  it "should have a NavCategoryDetail record" do
    subject.parse_and_update("NAVCategoryDetails.xml")
    NavCategoryDetail.exists?( conditions: { scheme_class_code: "2120",
                                             scheme_class_description: "Equity - Diversified",
                                             no_of_schemes: 288 ,
                                             one_month_return: "6.1578",
                                             three_year_return: "61.448" } ).should be_true
  end

  it "should have a Navcp record" do
    subject.parse_and_update("NAVCP.xml")
    Navcp.exists?( conditions: { security_code: "14051233.002199",
                                 ticker: "Sahara Tax Gain (D)",
                                 nav_amount: "13.6985",
                                 prev1_week_amount: "13.5208",
                                 prev3_year_per: "44.2554759898905",
                                 prev9_months_amount: "13.7376",
                                 prev3_months_per: "3.85046927357361" } ).should be_true
  end

  it "should have a NavMaster record" do
    subject.parse_and_update("NavMaster.xml")
    NavMaster.exists?( conditions: { security_code: "14051233.002199",
                                     scheme_code: "14051233",
                                     bench_mark_index_name: "NSE Index" } ).should be_true
  end

  it "should have a NavMonthlyDetail record " do
    subject.parse_and_update("NAVMonthlyDetails.xml")
    NavMonthlyDetail.exists?( conditions: { security_code: "14050001.032066",
                                            nav_date: "09/02/2012",
                                            open_nav: 52.46,
                                            high_nav: 54.35,
                                            low_date: "01/02/2012",
                                            close_date: "09/02/2012" } ).should be_true
  end

  it "should have a NavQuarterlyDetail record" do
    subject.parse_and_update("NAVQuarterlyDetails.xml")
    NavQuarterlyDetail.exists?( conditions: { security_code: "017023928.00026005004",
                                              year_end: "2012",
                                              q1_open_nav: 15534.67,
                                              ann_close_nav: 17830.75 } ).should be_true
  end

  it "should have a NavWeeklyDetail record" do
    subject.parse_and_update("NAVWeeklyDetails.xml")
    NavWeeklyDetail.exists?( conditions: { security_code: "14050001.032066",
                                           nav_date: "09/02/2012",
                                           open_nav: "53.93",
                                           close_nav: "54.35",
                                           high_date: "09/02/2012" } ).should be_true
  end

  it "should have a News record" do
    subject.parse_and_update("News.xml")
    News.exists?( conditions: { company_code: "230",
                                news_date: "10/02/2012",
                                headlines: "Indian refiners seek 2.6 million barrels extra supplies from Saudi Aramco: Sources",
                                source_name: "Religare Technova" } ).should be_true
  end

  it "should have a NinemonthsResult record" do
    subject.parse_and_update("NinemonthsResults.xml")
    NinemonthsResult.exists?( conditions: { company_code: "10560013",
                                            year_ending: "31/12/2011",
                                            months: 9,
                                            nine: 1,
                                            operating_income: "211490000",
                                            equity_capital: "79161000",
                                            eps: 2.134 } ).should be_true
  end

  it "should have a NotesToAccount record" do
    subject.parse_and_update("NotesToAccount.xml")
    NotesToAccount.exists?( conditions: { company_code: "17020538", year_ending: "31/03/2010" } ).should be_true
  end

  it "should have a NsePrice record" do
    subject.parse_and_update("NSEPrice.xml")
    NsePrice.exists?( conditions: { security_code: "017023929.00026005010",
                                    price_date: "10/02/2012",
                                    high_price: 19,
                                    close_price: 19,
                                    traded_value: 0,
                                    traded_quantity: 0 } ).should be_true
  end

  it "should have a Product record" do
    subject.parse_and_update("Products.xml")
    record = Product.where( company_code: "11020009", year_ending: "31/03/2010", no_of_months: 12 ).first
    record.element.first["ProductCode"].should eq "100190.0205"
    record.element.first["OpeningValue"].should eq nil
    record.element.first["ProductName"].should eq "Wheat Items"
  end

  it "should have a QuarterlyResult record" do
    subject.parse_and_update("QuarterlyResults.xml")
    record = QuarterlyResult.where( company_code: "10520003",
                                    year_ending: "31/12/2011",
                                    months: 3,
                                    quarter: 3 ).first
    record.operating_income.to_i.should eq 83868100000
    record.gross_profit.to_i.should eq 10548700000
    record.reported_pat.to_i.should eq 6621500000
  end

  it "should have a Ratio record" do
    subject.parse_and_update("Ratios.xml")
    record = Ratio.where( company_code: "12540153",
                          year_ending: "31/03/2011",
                          months: 12,
                          adjusted_eps: "0.0585",
                          long_term_assets: "0.4147",
                          net_profit_margin: "0.57",
                          operating_cash_flow_to_sales_ratio: "-0.0011" ).first
    record.type.should eq "A"
  end

  it "should have a Rawmaterial record" do
    subject.parse_and_update("Rawmaterial.xml")
    raw_material = Rawmaterial.where( company_code: "11020009", year_ending: "31/03/2010")
    raw_material.first.element["ProductCode"].to_f.should eq 999999.1224
    raw_material.first.element["ProdMix"].to_f.should eq 100
  end

  it "should have a SchemeMaster record" do
    subject.parse_and_update("SchemeMaster.xml")
    SchemeMaster.exists?( conditions: { securitycode: "14051233.002199",
                                        company_code: "14051231",
                                        scheme_type_description: "Open Ended",
                                        initial_price_uom: 763,
                                        fund_manager_name: "Aniket Inamdar",
                                        sip: "True" } ).should be_true
  end

  it "should have a ShareHolding record" do
    subject.parse_and_update("ShareHolding.xml")
    share_holding = ShareHolding.where( company_code: "10560013", share_holding_date: "31/12/2011" )
    share_holding.first.element.first["NoOfShareHolders"].to_i.should eq 5406
    share_holding.first.element.first["DistinctiveNumbers"].should eq "1 to 7916167"
    share_holding.first.element.first["EquityShareHold"].to_i.should eq 59665
  end

  it "should have a Split record" do
    subject.parse_and_update("Splits.xml")
    Split.exists?( conditions: { companycode: "14010105" } ).should be_true
  end

  it "should have a Subsidiary record" do
    subject.parse_and_update("Subsidiaries.xml")
    Subsidiary.exists?( conditions: { company_code: "13191258", company_name: "Kautilya Infotech Ltd.", parent_company_code: "16030148" } ).should be_true
  end

end
