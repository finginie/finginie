require 'nokogiri'
require 'open-uri'
module TickerHelper
  TickerPath =
    {
      'sensex_current' =>
        [
          'http://www.bseindia.com/mktlive/mktwatch.asp',
          '//html/body/table/tr[3]/td[1]/table/tr/td/table/tr[4]/td[5]/font/text()'
        ],
      'sensex_change' =>
        [
          'http://www.bseindia.com/mktlive/mktwatch.asp',
          '//html/body/table/tr[3]/td[1]/table/tr/td/table/tr[4]/td[7]/font/text()'
        ],
      'nifty_current' =>
        [
          'http://www.nseindia.com/content/equities/niftysparks.htm',
          '//*[@class="nifty"]/tr[2]/td[7]/text()'
        ],
      'nifty_change' =>
        [
          'http://www.nseindia.com/content/equities/niftysparks.htm', 
          '//*[@class="nifty"]/tr[2]/td[8]/text()'
        ],
      'dowjones_current' =>
        [
          'http://money.cnn.com/data/markets',
          '//*[@class="tickerDow"]/div/span/span/text()'
        ],
      'dowjones_change' =>
        [
          'http://money.cnn.com/data/markets',
          '//*[@class="tickerDow"]/span[1]/span/text()'
        ],
      'usd_to_inr' =>
        [
          'http://www.exchangerateusd.com/INR',
          '//html/body/div[1]/div/div/table/tr/td[2]/div/table/tr[2]/td[5]/a/text()'
        ],
      'gold_current' =>
        [
          'http://www.mcxindia.com/',
          '//*[@id="205933"]/span[2]/text()'
        ]
    }

  def indice_result(indice_name)
    indice_url = TickerPath[indice_name][0]
    indice_xpath = TickerPath[indice_name][1]
    indice_doc = Nokogiri::HTML(open(indice_url))
    indice_data = indice_doc.xpath(indice_xpath)
  end
end
