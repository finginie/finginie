class IndustryMaster
  include Mongoid::Document
  extend MongoidHelpers

  field :industry_code, :type => Integer
  field :industry_name
  field :broad_industry_code, :type => Integer
  field :broad_industry_name
  field :major_sector_code, :type => Integer
  field :major_sectorName
  field :modified_date, :type => DateTime
  field :delete_flag

  key :industry_code
end
