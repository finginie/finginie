require 'spec_helper'

describe SchemeDecorator, :mongoid do
  before { ApplicationController.new.set_current_view_context }

  it "should have top funds" do
    5.times { |i| create :scheme, :name => "scheme-#{i}",:nav_amount => 2 * i + 2, :percentage_change => 5 * i + 1,
        :prev1_month_percent =>  6 * i + 3, :prev_year_percent =>  6 * i + 5, :prev3_year_percent =>  6 * i + 6 }

    SchemesDecorator.top_performers.map(&:percentage_change).should include( 1.0, 6.0, 11.0, 16.0, 21.0 )
  end

  it "should have biggest funds" do
    5.times { |i| create :scheme, :name => "scheme-#{i}",:nav_amount => 2 * i + 2, :percentage_change => 5 * i + 1,
      :size => 238.68 + i * 100, :prev_year_percent =>  6 * i + 5  }

    SchemesDecorator.biggest_schemes.map(&:size).should include( 638.68, 538.68, 438.68, 338.68, 238.68 )
  end
end
