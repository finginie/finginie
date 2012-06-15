require 'spec_helper'

describe MutualFundsCell, :mongoid do
  context "cell rendering" do

    context "rendering top_funds" do
      before(:each) do
        2.times { |i| create :'data_provider/scheme', :name => "scheme-#{i}",:nav_amount => 2 * i + 2, :percentage_change => 5 * i + 1,
          :prev1_month_percent =>  6 * i + 3, :prev_year_percent =>  6 * i + 5, :prev3_year_percent =>  6 * i + 6 }
      end
      subject { render_cell(:mutual_funds, :top_funds) }

      it  "should have the table" do
        expected_content = [
          [ 'scheme-0', '2.0', '1.00', '3.00', '5.00', '6.00' ],
          [ 'scheme-1', '4.0', '6.00', '9.00', '11.00', '12.00' ] ]

        table_rows(subject, "#top_performers").should include *expected_content

      end
      it { should have_css("#top_performers") }
    end

    context "rendering biggest_funds" do
      before(:each) do
        2.times { |i| create :'data_provider/scheme', :name => "scheme-#{i}",:nav_amount => 2 * i + 2, :percentage_change => 5 * i + 1,
          :size => 238.68 + i * 100, :prev_year_percent =>  6 * i + 5  }
      end

      subject { render_cell(:mutual_funds, :biggest_funds) }

      it "should have table content" do
        expected_content = [
          [ 'scheme-0', '2.0', '1.00', '238.68', '5.00' ],
          [ 'scheme-1', '4.0', '6.00', '338.68', '11.00' ] ]

        table_rows(subject, "#biggest_schemes").should include *expected_content
      end
    end
  end


  context "cell instance" do
    subject { cell(:mutual_funds) }

    it { should respond_to(:top_funds) }
    it { should respond_to(:biggest_funds) }
  end
end
