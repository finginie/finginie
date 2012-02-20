require 'spec_helper'

describe AnnouncementsBoardMeeting, :mongoid do
  let (:announcements_board_meeting) { AnnouncementsBoardMeeting.new :company_code => "14010051",
          :brd_date => "30/12/2011",
          :purpose => "Issue of Fully Convertible Debenture",
          :src_code => "584",
          :src_name => "BSE Bulletin",
          :src_date => "26/12/2011",
          :remarks => "To issue and allot 1,48,574 Fully Convertible Debenture of Rs. 1000/- each to the FDC Holder of Goldcrest Trade & Merchandise Pvt. Ltd. in pursuant to sanctioned scheme of Amalgamation.",
          :modified_date => "26/12/2011 18:52",
          :delflag => "False" }
  it "should add a record to the database" do
    announcements_board_meeting.save.should be_true
  end
end
