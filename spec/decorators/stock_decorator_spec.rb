require 'spec_helper'

describe StockDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:stock) {create :stock, :eps => '1424.32001' }
  let(:stock_decorator) { StockDecorator.decorate(stock) }
  subject { stock_decorator }

  its(:eps) { should eq 1424.0 }
  its(:fifty_two_week_high_price) { should eq "N/A" }
end
