require 'spec_helper'

describe CashFlowCollectionDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:company_master) { create :company_master }
  let(:cash_flows) { 5.times.map { |i| create :cash_flow, :company_code => company_master.company_code,
                                                          :year_ending  => "31/03/#{2006 + i}",
                                                          :pbt          => "139260961000",
                                                          :depreciatn	  => "9326637000",
                                                          :pl_sale_asst => "104562000",
                                                          :pl_sale_invs	=> "-21167923000",
                                                          :int_paid_net	=> "25386722000",
                                                          :dvdnd_rec_op	=> "-5734834000",
                                                          :prov_w_off_nt=> "2155591000",
                                                          :prov_dim_inv	=> "-9685958000",
                                                          :prov_bdnpa  	=> "51478528000",
                                                          :dirct_taxes  => "-69148675000"
  } }
  let(:cash_flow_collection) { CashFlowCollectionDecorator.new(cash_flows) }

  subject { cash_flow_collection }
  its (:collection_non_null_fields) { should include( "depreciatn",
                                                      "pbt",
                                                      "pl_sale_asst",
                                                      "pl_sale_invs",
                                                      "int_paid_net",
                                                      "prov_w_off_nt",
                                                      "prov_dim_inv",
                                                      "prov_bdnpa",
                                                      "dirct_taxes" ) }
  its (:collection_non_null_fields) { should_not include("id", "_id","company_code") }
end
