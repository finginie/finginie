require 'spec_helper'

describe ScripBse, :redis do
  #it_should_behave_like "ActiveModel"

  let (:scrip) { ScripBse.new :id => "AANJANEYA",
                           :bse_last_traded_price => "426.45",
                           :bse_volume => "87942",
                           :bse_open_price => "425.40",
                           :bse_high_price => "432.5",
                           :bse_low_price => "419.15",
                           :bse_close_price => "421.90" }
  subject { scrip }

  its(:bse_volume) { should eq 87942 }
  its(:bse_net_change) { should eq 4.55 }
  its(:bse_percent_change) { should eq 1.08 }

  it "should be persisted" do
    scrip.save.should be_true
    scrip.persisted.should be_true
  end

  it "should update attributes" do
    scrip.update_attributes({ :bse_volume => "10000", :bse_open_price => "2300"}).should be_true
    scrip.persisted.should be_true
    scrip.bse_volume.should eq 10000
    scrip.bse_open_price.should eq 2300
  end

  describe "with saved scrip" do
    before { scrip.save }
    it "should find a scrip by id" do
      scrip = ScripBse.find("AANJANEYA")
      scrip.should be_kind_of ScripBse
      scrip.bse_last_traded_price.should eq 426.45
    end

    it "should find all scrips" do
      ScripBse.all.should eq [scrip]
    end

    it "should return nil for a missing scrip" do
      ScripBse.find(999999999).should be_nil
    end

    describe "using find or initialize" do
      it "should find a scrip by id" do
        scrip = ScripBse.find_or_initialize_by_id("AANJANEYA")
        scrip.should be_kind_of ScripBse
        scrip.bse_last_traded_price.should eq 426.45
      end

      it "should return new scrip for a missing scrip" do
        scrip = ScripBse.find_or_initialize_by_id("FOOBAR")
        scrip.should be_kind_of ScripBse
        scrip.id.should eq "FOOBAR"
        scrip.update_attributes({ :bse_volume => "10000", :bse_open_price => "2300"}).should be_true
        scrip.persisted.should be_true
        ScripBse.find("FOOBAR").bse_volume.should eq 10000
        ScripBse.find("FOOBAR").bse_open_price.should eq 2300
      end
    end

    it "should find a scrip by last traded price range" do
      ScripBse.find_ids_by_bse_last_traded_price( 420, 425 ).should eq []
      ScripBse.find_ids_by_bse_last_traded_price( 426.25, 430 ).should eq ["AANJANEYA"]
    end

    it "should be destroyable" do
      destroyed_scrip = scrip.destroy
      destroyed_scrip.should eq scrip
      ScripBse.find(destroyed_scrip.id).should be_nil
    end

    it "should clear indices on destroyed scrips" do
      destroyed_scrip = scrip.destroy
      ScripBse.find_ids_by_bse_last_traded_price( destroyed_scrip.bse_last_traded_price, destroyed_scrip.bse_last_traded_price ).should eq []
    end
  end
end
