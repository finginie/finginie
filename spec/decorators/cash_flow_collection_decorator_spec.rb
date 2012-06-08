require 'spec_helper'

describe CashFlowCollectionDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:company) { create :'data_provider/company' }
  let(:cash_flows) { 5.times.map { |i| create :'data_provider/cash_flow', :company_code => company.code,
                                                          :year_ending  => "31/03/#{2006 + i}",
                                                          :profits_before_tax          => "139260961000",
                                                          :depreciation	  => "9326637000",
                                                          :pl_on_sale_of_assets => "104562000",
                                                          :pl_on_sale_of_investments	=> "-21167923000",
                                                          :interest_paid_net	=> "25386722000",
                                                          :dividend_received_operating_activity	=> "-5734834000",
                                                          :provisions_written_off_net=> "2155591000",
                                                          :provisions_dimun_in_value_of_investment	=> "-9685958000",
                                                          :provisions_for_bad_debts_npa  	=> "51478528000",
                                                          :direct_taxes  => "-69148675000"
  } }
  let(:cash_flow_collection) { CashFlowCollectionDecorator.new(cash_flows) }

  subject { cash_flow_collection }
  its (:collection_non_null_fields) { should include( "depreciation",
                                                      "profits_before_tax",
                                                      "pl_on_sale_of_assets",
                                                      "pl_on_sale_of_investments",
                                                      "interest_paid_net",
                                                      "provisions_written_off_net",
                                                      "provisions_dimun_in_value_of_investment",
                                                      "provisions_for_bad_debts_npa",
                                                      "direct_taxes" ) }
  its (:collection_non_null_fields) { should_not include("id", "_id","company_code") }
end
