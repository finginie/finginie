require 'spec_helper'

describe FixedDepositsCell, :vcr do
  context "cell rendering" do

    context "special tenure" do
      subject do
        @request.env["action_dispatch.request.request_parameters"] = {fixed_deposit_query:                       #Cell need this to set request parameters
                                                        {senior_citizen: "Yes", month: "1", year:"1", days:"1"}}
        @controller = Class.new(ActionController::Base).new
        @controller.request = @request
        render_cell(:fixed_deposits, :special_tenure)
      end

      it  "should have the table" do
        expected_content = [
            ["Bank of Baroda", "444", "9.35"]
        ]

        table_rows(subject, "#special_tenure").should include *expected_content

      end
      it { should have_css("#special_tenure") }
    end

    context "cell instance" do
      subject { cell(:fixed_deposits) }

      it { should respond_to(:special_tenure) }
    end
  end
end
