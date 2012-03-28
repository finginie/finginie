require 'spec_helper'

describe SchemeDecorator do
  before { ApplicationController.new.set_current_view_context }

  before(:each) do
    @scheme = create :scheme
    @amc =  create :asset_management_company, :company_code => @scheme.company_code, :company_name => "HDFC Mutual Fund"
    @navcp = create :navcp, :security_code => @scheme.securitycode
    @mf_dividend_detail = create :mf_dividend_detail, :securitycode => @scheme.securitycode
    @nav_category_detail = create :nav_category_detail, :scheme_class_code => @scheme.scheme_class_code
    @mf_scheme_wise_portfolio = create :mf_scheme_wise_portfolio, :security_code => @scheme.securitycode
  end

  let(:scheme_decorator) { SchemeDecorator.decorate(@scheme) }

  subject { scheme_decorator }

  its(:sip) { should eq "Yes" }
  its(:entry_load) { should eq "-" }
  its(:exit_load) { should eq "-" }
end
