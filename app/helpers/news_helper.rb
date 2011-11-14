module NewsHelper
  SECTIONAL_FEED_URLS = {
    'stock_markets' => {
      'http://www.ft.com/rss/markets' => 'Financial Times',
      'http://syndication.financialexpress.com/rss/98/world-news.xml' => 'Financial Express'
    },
    'economy_news' => {
      'http://economictimes.feedsportal.com/c/33041/f/534033/index.rss' => 'Economic Times',
      'http://syndication.financialexpress.com/rss/97/economy.xml' => 'Financial Express'
    },
    'world_news' => {
      'http://economictimes.feedsportal.com/c/33041/f/534037/index.rss' => 'Economic Times',
      'http://syndication.financialexpress.com/rss/96/markets.xml' => 'Financial Express'
    },
    'ipos' => {
      'http://economictimes.feedsportal.com/c/33041/f/534040/index.rss' => 'Economic Times',
      'http://feeds.feedburner.com/IpoAlertBlog' => 'IPO Investment Blog'
    },
    'results' => {
      'http://economictimes.feedsportal.com/c/33041/f/534040/index.rss' => 'Economic Times',
      'http://feeds.feedburner.com/IpoAlertBlog' => 'IPO Investment Blog'
    },
    'sector_spotlights' => {
      'http://www.livemint.com/SectionRssfeed.aspx?Id=21' => 'Live Mint',
      'http://www.livemint.com/SectionRssfeed.aspx?Id=21' => 'Live Mint'
    },
    'commodities' => {
      'http://www.commodityonline.com/rssfeed/topstorynews_rss.xml' => 'Commodity Online',
      'http://syndication.financialexpress.com/rss/375/commodities.xml' => 'Financial Express'
    }
  }

  def get_feeds(section_name)
    @feeds = Feedzirra::Feed.fetch_and_parse(SECTIONAL_FEED_URLS[section_name].keys).map { |url, parser|
      parser.entries.map { |entry|
        {
          :title =>  entry.title,
          :summary => entry.summary,
          :published => entry.published,
          :source => SECTIONAL_FEED_URLS[section_name][url],
          :url => entry.url
        }
      }
    }.flatten.sort_by {|e| e[:published]}.reverse
  end
end
