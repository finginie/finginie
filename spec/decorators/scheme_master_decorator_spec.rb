require 'spec_helper'

describe SchemeMasterDecorator do
  before { ApplicationController.new.set_current_view_context }

  before(:each) do
    @scheme_master = create :scheme_master
    @fund_master =  create :fund_master, :company_code => @scheme_master.company_code, :company_name => "HDFC Mutual Fund"
    @nav_master = create :nav_master, :security_code => @scheme_master.securitycode, :bench_mark_index_name => "Crisil Liquid Fund Index"
    @navcp = create :navcp, :security_code => @scheme_master.securitycode
    @mf_objective = create :mf_objective, :securitycode => @scheme_master.securitycode
    @mf_dividend_detail = create :mf_dividend_detail, :securitycode => @scheme_master.securitycode
    @nav_category_detail = create :nav_category_detail, :scheme_class_code => @scheme_master.scheme_class_code
    @mf_scheme_wise_portfolio = create :mf_scheme_wise_portfolio, :security_code => @scheme_master.securitycode
  end

  let(:scheme_master_decorator) { SchemeMasterDecorator.decorate(@scheme_master) }

  subject { scheme_master_decorator }

  its(:sip) { should eq "Yes" }
  its(:entry_load) { should eq "-" }
  its(:exit_load) { should eq "-" }
end
