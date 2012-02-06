require 'spec_helper'

describe AnnouncementsAgmbc do
  let(:company_master) { create :company_master }
  let(:announcements_agmbc) { create :announcements_agmbc , :company_code => company_master.company_code,
                                                            :date_of_announcement => "12/01/2012",
                                                            :agm_date => "12/01/2012",
                                                            :remarks => "Remarks" }
  subject { announcements_agmbc }
  its(:remarks) { should eq "Remarks" }
  it "should get the record by company_code" do
    AnnouncementsAgmbc.find_or_initialize_by( company_code: company_master.company_code, date_of_announcement: announcements_agmbc.date_of_announcement, agm_date: announcements_agmbc.agm_date ).should eq announcements_agmbc
  end
end
