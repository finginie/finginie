class CompanyDecorator < ApplicationDecorator
  decorates :company

  FIELDS_TO_ROUND = [  'eps', 'pe', 'price_to_book_value', 'market_capitalization', 'book_value', 'face_value', 'dividend_yield']

  FIELDS_TO_ROUND.each do |key|                                                              ##
    define_method(key.to_sym) do                                                             # def key
      model.send(key) ?  model.send(key).round(2) : h.t('not_available')                     #   key ? key.round(2) : "N/A"
    end                                                                                      # end
  end                                                                                        ##

  def share_holding
    ShareHoldingDecorator.decorate(model.share_holding) if model.share_holding
  end

  def ratio
    if major_sector == 2
      @ratio = BankingRatio.all( conditions: { company_code: company_code }, sort: [[ :year_ending, :desc ]] ).first
      @ratio = BankingRatioDecorator.decorate(@ratio) if @ratio
    else
      @ratio = Ratio.all( conditions: { company_code: company_code }, sort: [[ :year_ending, :desc ]] ).first
      @ratio = RatioDecorator.decorate(@ratio) if @ratio
    end

  end

  def news
    News.for_company(company_code).latest(5)
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
