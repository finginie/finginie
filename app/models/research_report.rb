class ResearchReport < SheetMappedRecord
  include ActiveAttr::Model
  attribute :reportdate,         type: Date
  attribute :source,             type: String
  attribute :reportname,         type: String
  attribute :companyname,        type: String
  attribute :sector,             type: String
  attribute :nse_code,           type: String
  attribute :bsecode,            type: String
  attribute :reportlink,         type: String
  attribute :recommendation,     type: String
  attribute :currentmarketprice, type: Float
  attribute :targetprice,        type: Float
end
