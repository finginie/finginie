class CompanyDecorator < ApplicationDecorator
  decorates :'data_provider/company'

  FIELDS_TO_ROUND = [  'eps', 'pe', 'price_to_book_value', 'book_value', 'face_value', 'dividend_yield']

  FIELDS_TO_ROUND.each do |key|                                                              ##
    define_method(key.to_sym) do                                                             # def key
      model.send(key) ?  model.send(key).round(2) : h.t('not_available')                     #   key ? key.round(2) : "N/A"
    end                                                                                      # end
  end                                                                                        ##

  def market_capitalization
    (model.market_capitalization) ? (model.market_capitalization / 10000000).round : h.t('tables_not_available')
  end

  def share_holding
    ShareHoldingDecorator.decorate(model.share_holding) if model.share_holding
  end

  def ratio
    if major_sector == 2
      @ratio = DataProvider::BankingRatio.all( conditions: { company_code: code }, sort: [[ :year_ending, :desc ]] ).first
      @ratio = BankingRatioDecorator.decorate(@ratio) if @ratio
    else
      @ratio = DataProvider::Ratio.all( conditions: { company_code: code }, sort: [[ :year_ending, :desc ]] ).first
      @ratio = RatioDecorator.decorate(@ratio) if @ratio
    end

  end

  def news
    DataProvider::News.for_company(code).latest(5)
  end

  def nse
    ScripDecorator.decorate(model.nse)
  end

  def bse
    ScripDecorator.decorate(model.bse)
  end

  def nse_listing
    ListingDecorator.decorate(model.nse_listing)
  end

  def bse_listing
    ListingDecorator.decorate(model.bse_listing)
  end
end
