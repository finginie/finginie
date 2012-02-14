class NavMonthlyDetail
  include Mongoid::Document
  extend MongoidHelpers

  field :security_code, :type => BigDecimal
  field :nav_date, :type => Date
  field :open_nav, :type => Float
  field :open_date, :type => Date
  field :high_nav, :type => Float
  field :high_date, :type => Date
  field :low_nav, :type => Float
  field :low_date, :type => Date
  field :close_nav, :type => Float
  field :close_date, :type => Date
  field :modified_date, :type => DateTime

  key :security_code, :nav_date
end
