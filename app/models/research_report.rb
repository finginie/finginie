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
    query = params[:query]
    params.keys.include?(:nse_code) ?
      self.all.select { |r| r.nse_code == params[:nse_code] || r.bse_code == params[:bse_code] } :
        query ? self.all.select { |r| r.source.include?(query) || r.company_name.include?(query) ||
          r.sector.include?(query) } : self.all

  end

end
