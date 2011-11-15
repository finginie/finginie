class NewsData

  FEEDS = [
    { :name => 'Financial Times',     :section => 'stock_markets',     :url => 'http://www.ft.com/rss/markets' },
    { :name => 'Economic Times',      :section => 'economy_news',      :url => 'http://economictimes.feedsportal.com/c/33041/f/534033/index.rss' },
    { :name => 'Financial Express',   :section => 'economy_news',      :url => 'http://syndication.financialexpress.com/rss/97/economy.xml' },
    { :name => 'Economic Times',      :section => 'world_news',        :url => 'http://economictimes.feedsportal.com/c/33041/f/534037/index.rss' },
    { :name => 'Financial Express',   :section => 'world_news',        :url => 'http://syndication.financialexpress.com/rss/96/markets.xml' },
    { :name => 'Economic Times',      :section => 'ipos',              :url => 'http://economictimes.feedsportal.com/c/33041/f/534040/index.rss' },
    { :name => 'IPO Investment Blog', :section => 'ipos',              :url => 'http://feeds.feedburner.com/IpoAlertBlog' },
    { :name => 'Economic Times',      :section => 'results',           :url => 'http://economictimes.feedsportal.com/c/33041/f/534040/index.rss' },
    { :name => 'IPO INvestment Blog', :section => 'results',           :url => 'http://feeds.feedburner.com/IpoAlertBlog' },
    { :name => 'LiveMint',            :section => 'sector_spotlights', :url => 'http://www.livemint.com/SectionRssfeed.aspx?Id=21' },
    { :name => 'Commodity Online',    :section => 'commodities',       :url => 'http://www.commodityonline.com/rssfeed/topstorynews_rss.xml' },
    { :name => 'Financial Express',   :section => 'commodities',       :url => 'http://syndication.financialexpress.com/rss/375/commodities.xml' }
  ]
  SECTIONAL_FEED_URLS = {
    'stock_markets' => {
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

  def self.store_feeds
    FEEDS.each do |feed|
      Feedzirra::Feed.fetch_and_parse(feed[:url]).entries.each do |entry|
        NewsArticle.new(
          :id => entry.title,
          :summary => entry.summary,
          :published => entry.published,
          :published_time => entry.published.to_i,
          :source => feed[:name],
          :url => entry.url,
          :section_name => feed[:section]
          ).save
        REDIS.lpush(NewsArticle.key(feed[:section]), entry.title)
      end
    end
  end

end
