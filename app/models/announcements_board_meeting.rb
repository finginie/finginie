class AnnouncementsBoardMeeting
  include Mongoid::Document
  extend MongoidHelpers

  field :company_code, :type => BigDecimal
  field :brd_date, :type => Date
  field :purpose
  field :src_code, :type => Integer
  field :src_name
  field :src_date, :type => Date
  field :remarks
  field :modified_date, :type => DateTime
  field :delflag

  key :company_code, :brd_date
end
