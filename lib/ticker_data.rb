require 'nokogiri'
require 'open-uri'
class TickerData
  INDICES =[
    {
      :category => 'Sensex',
      :name => 'sensex_current',
      :url => 'http://www.bseindia.com/mktlive/mktwatch.asp',
      :xpath => '//html/body/table/tr[3]/td[1]/table/tr/td/table/tr[4]/td[5]/font/text()'
    },
    {
      :category => 'Sensex',
      :name => 'sensex_change',
      :url => 'http://www.bseindia.com/mktlive/mktwatch.asp',
      :xpath => '//html/body/table/tr[3]/td[1]/table/tr/td/table/tr[4]/td[7]/font/text()'
    },
    {
      :category => 'Nifty',
      :name => 'nifty_current',
      :url => 'http://www.nseindia.com/content/equities/niftysparks.htm',
      :xpath => '//*[@class="nifty"]/tr[2]/td[7]/text()'
    },
    {
      :category => 'Nifty',
      :name => 'nifty_change',
      :url => 'http://www.nseindia.com/content/equities/niftysparks.htm',
      :xpath => '//*[@class="nifty"]/tr[2]/td[8]/text()'
    },
    {
      :category => 'DowJones',
      :name => 'dowjones_current',
      :url => 'http://money.cnn.com/data/markets',
      :xpath => '//*[@class="tickerDow"]/div/span/span/text()'
    },
    {
      :category => 'DowJones',
      :name => 'dowjones_change',
      :url => 'http://money.cnn.com/data/markets',
      :xpath => '//*[@class="tickerDow"]/span[1]/span/text()'
    },
    {
      :category => 'USD 1',
      :name => 'usd_to_inr',
      :url => 'http://www.exchangerateusd.com/INR',
      :xpath => '//html/body/div[1]/div/div/table/tr/td[2]/div/table/tr[2]/td[5]/a/text()'
    },
    {
      :category => 'Gold (10gms)',
      :name => 'gold_current',
      :url => 'http://www.mcxindia.com/',
      :xpath => '//*[@id="205933"]/span[2]/text()'
    }
  ]

  def self.store_indices
    INDICES.each{ |index|  REDIS.set("Ticker_#{index[:name]}",Nokogiri::HTML(open(index[:url])).xpath(index[:xpath])[0].content.strip) }
  end

end
