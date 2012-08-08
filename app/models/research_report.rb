class ResearchReport < SheetMappedRecord
  include CurrencyFormatter

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

  monetize :current_market_price, :target_price

  def recommendation_value
    case recommendation
    when 'Buy';       ResearchRating::BUY
    when 'Neutral';   ResearchRating::NEUTRAL
    when 'Accumlate'; ResearchRating::Accumlate
    when 'Sell';      ResearchRating::SELL
    else 0
    end
  end

  def self.filter(params)
    query = params[:query].downcase if params[:query]
    reports = params.keys.include?(:nse_code) ? find_all_by_company(params) : all
    reports = reports.select { |r| r.source.downcase.include?(query) || r.company_name.downcase.include?(query) ||
          r.sector.downcase.include?(query) } if query

    reports
  end

  def self.short_term(company)
    report_by_company = find_all_by_company({:nse_code => company})
    report_by_company.select { |r| r.date >= Date.today.prev_month(3) }
  end

  def self.find_all_by_company(params)
    all.select { |r| r.nse_code == params[:nse_code] || r.bse_code == params[:bse_code] }
  end
end
