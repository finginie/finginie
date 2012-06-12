require 'spec_helper'

describe SchemeDecorator do
  before { ApplicationController.new.set_current_view_context }

  before(:each) do
    @scheme = create :'data_provider/scheme'
    @amc =  create :'data_provider/asset_management_company', :company_code => @scheme.company_code, :company_name => "HDFC Mutual Fund"
    @mf_dividend_detail = create :'data_provider/mf_dividend_detail', :security_code => @scheme.security_code
    @nav_category_detail = create :'data_provider/net_asset_value_category', :scheme_class_code => @scheme.class_code
    @mf_scheme_wise_portfolio = create :'data_provider/mf_scheme_wise_portfolio', :security_code => @scheme.security_code
  end

  let(:scheme_decorator) { SchemeDecorator.decorate(@scheme) }

  subject { scheme_decorator }

  its(:sip) { should eq "Yes" }
  its(:entry_load) { should eq "-" }
  its(:exit_load) { should eq "-" }
end
