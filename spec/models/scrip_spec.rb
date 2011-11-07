require 'spec_helper'

describe Scrip, :redis do
  #it_should_behave_like "ActiveModel"

  let (:scrip) { Scrip.new :id => "8118",
                           :symbol => "AANJANEYA",
                           :company_name => "Aanjaneya Lifecare",
                           :best_buy_quantity => "9008",
                           :best_buy_price => "426.45",
                           :best_sell_quantity => "0",
                           :best_sell_price => "0",
                           :last_traded_price => "426.45",
                           :volume => "87942",
                           :net_change => "4.55",
                           :percent_change => "1.08",
                           :open_price => "425.40",
                           :high_price => "432.5",
                           :low_price => "419.15",
                           :close_price => "421.90" }
  subject { scrip }

  it "should be persisted" do
    scrip.save.should be_true
    scrip.persisted.should be_true
  end

  it "should update attributes" do
    scrip.update_attributes({ :volume => "10000", :open_price => "2300"}).should be_true
    scrip.persisted.should be_true
    scrip.volume.should eq 10000
    scrip.open_price.should eq 2300
  end

  describe "with saved scrip" do
    before { scrip.save }
    it "should find a scrip by id" do
      scrip = Scrip.find(8118)
      scrip.should be_kind_of Scrip
      scrip.company_name.should eq "Aanjaneya Lifecare"
      scrip.last_traded_price.should eq 426.45
    end

    it "should return nil for a missing scrip" do
      Scrip.find(999999999).should be_nil
    end

    describe "using find or initialize" do
      it "should find a scrip by id" do
        scrip = Scrip.find_or_initialize_by_id(8118)
        scrip.should be_kind_of Scrip
        scrip.company_name.should eq "Aanjaneya Lifecare"
        scrip.last_traded_price.should eq 426.45
      end

      it "should return new scrip for a missing scrip" do
        scrip = Scrip.find_or_initialize_by_id(999999)
        scrip.should be_kind_of Scrip
        scrip.id.should eq 999999
      end
    end

    it "should find a scrip by last traded price range" do
      Scrip.find_ids_by_last_traded_price( 420, 425 ).should eq []
      Scrip.find_ids_by_last_traded_price( 426.25, 430 ).should eq [8118]
    end

    it "should find a scrip by percent change range" do
      Scrip.find_ids_by_percent_change( 4, 5 ).should eq []
      Scrip.find_ids_by_percent_change( 1, 2 ).should eq [8118]
    end
  end
end
