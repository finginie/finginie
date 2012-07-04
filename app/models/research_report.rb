class ResearchReport < SheetMappedRecord
  include ActiveAttr::Model
  attribute :date,                 type: Date
  attribute :source,               type: String
  attribute :name,                 type: String
  attribute :company_name,         type: String
  attribute :sector,               type: String
  attribute :nse_code,             type: String
  attribute :bse_code,             type: String
  attribute :link_url,             type: String
  attribute :recommendation,       type: String
  attribute :current_market_price, type: Float
  attribute :target_price,         type: Float
end
