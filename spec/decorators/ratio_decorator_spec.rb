require 'spec_helper'

describe RatioDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:ratio) { create :ratio, :current_ratio => "1.233455",
                               :quick_ratio  => "2.3455" }
  let(:ratio_decorator) { RatioDecorator.decorate ratio }

  subject { ratio_decorator }

  its(:current_ratio)          { should eq 1.23 }
  its(:quick_ratio)            { should eq 2.35 }
  its(:free_reserves_per_share){ should eq "NA" }
end
