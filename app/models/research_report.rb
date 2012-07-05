class ResearchReport < SheetMappedRecord

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

  def self.filter(params)
    query = params[:query].downcase if params[:query]
    reports = params.keys.include?(:nse_code) ? find_all_by_company(params) : all
    reports = reports.select { |r| r.source.downcase.include?(query) || r.company_name.downcase.include?(query) ||
          r.sector.downcase.include?(query) } if query

    reports
  end

  def self.find_all_by_company(params)
    all.select { |r| r.nse_code == params[:nse_code] || r.bse_code == params[:bse_code] }
  end
end
