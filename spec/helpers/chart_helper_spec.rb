require 'spec_helper'

describe ChartHelper do
  before(:each) do
    helper.extend Haml
    helper.extend Haml::Helpers
    helper.send :init_haml_helpers
  end

  it "should generate a google chart content" do
    helper.capture_haml {
      helper.gchart(:data => [[1,2]], :header => ['',''], :title => 'Asset allocation')
    }.should eq "<div class='chart' data-elements='[[\"\", \"\"], [\"1\", 2.0]]' data-title='Asset allocation' id='asset-allocation'></div>\n"
  end

  context "#no_data" do
    it "should display the default message" do
    helper.capture_haml {
      helper.gchart(:data => [], :title => 'Asset allocation')
    }.should eq "<div>\n  <span>#{I18n.t('.data_not_available')}</span>\n</div>\n"
    end
  end
end
