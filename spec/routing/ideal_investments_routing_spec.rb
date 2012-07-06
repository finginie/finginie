require 'spec_helper'

describe IdealInvestmentsController do

  it "should route to ideal_investments#show" do
    get('comprehensive_risk_profiler/ideal_investments').should route_to('ideal_investments#show')
  end
end
