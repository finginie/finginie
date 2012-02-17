require 'spec_helper'

describe SchemeMaster do
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

  subject { @scheme_master }

  its(:company_name) { should eq @fund_master.company_name }
  its(:bench_mark_index) { should eq @nav_master.bench_mark_index_name }
  its(:objective) { should eq @mf_objective.objective }
  its(:dividend_percentage) { should eq @mf_dividend_detail.percentage }
  its(:dividend_date) { should eq @mf_dividend_detail.dividend_date }
  its(:one_day_return) { should eq @nav_category_detail.one_day_return }
  its(:one_year_return) { should eq @nav_category_detail.one_year_return }
  its(:prev1_week_per) { should eq @navcp.prev1_week_per }
  its(:prev3_months_per) { should eq @navcp.prev3_months_per }
  its(:prev9_months_per) { should eq @navcp.prev9_months_per }
  its(:prev3_year_comp_per) { should eq @navcp.prev3_year_comp_per }
end
