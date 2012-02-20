class NavQuarterlyDetail
  include Mongoid::Document
  extend MongoidHelpers

  field :security_code, :type => BigDecimal
  field :year_end, :type => Integer
  field :q1_open_nav, :type => BigDecimal
  field :q1_close_nav, :type => BigDecimal
  field :q1_growth, :type => Float
  field :q2_open_nav, :type => BigDecimal
  field :q2_close_nav, :type => BigDecimal
  field :q2_growth, :type => Float
  field :q3_open_nav, :type => BigDecimal
  field :q3_close_nav, :type => BigDecimal
  field :q3_growth, :type => Float
  field :q4_open_nav, :type => BigDecimal
  field :q4_close_nav, :type => BigDecimal
  field :q4_growth, :type => Float
  field :ann_open_nav, :type => BigDecimal
  field :ann_close_nav, :type => BigDecimal
  field :ann_growth, :type => Float
  field :modified_date, :type => DateTime

  key :security_code, :year_end
end
