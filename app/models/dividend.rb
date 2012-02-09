class Dividend
  include Mongoid::Document

  field  :company_code, :type => Float
  field  :date_of_announcement, :type => DateTime
  field  :interim_or_final
  field  :instrument_type, :type => Integer
  field  :instrument_type_description
  field  :percentage, :type => BigDecimal
  field  :value, :type => BigDecimal
  field  :record_date, :type => Date
  field  :book_closure_start_date, :type => Date
  field  :book_closure_end_date, :type => Date
  field  :remarks
  field  :modified_date, :type => DateTime
  field  :del_flag
  field  :xd_date, :type => DateTime

  key :company_code, :date_of_announcement
end
