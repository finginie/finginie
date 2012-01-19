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
    { :name => 'IPO Investment Blog', :section => 'results',           :url => 'http://feeds.feedburner.com/IpoAlertBlog' },
    { :name => 'LiveMint',            :section => 'sector_spotlights', :url => 'http://www.livemint.com/SectionRssfeed.aspx?Id=21' },
    { :name => 'Commodity Online',    :section => 'commodities',       :url => 'http://www.commodityonline.com/rssfeed/topstorynews_rss.xml' },
    { :name => 'Financial Express',   :section => 'commodities',       :url => 'http://syndication.financialexpress.com/rss/375/commodities.xml' }
  ]

  def self.store_feeds
    FEEDS.each do |feed|
      Feedzirra::Feed.fetch_and_parse(feed[:url]).entries.each do |entry|
        article = NewsArticle.new :id => entry.title,
                                  :summary => entry.summary || "",
                                  :published => entry.published,
                                  :source => feed[:name],
                                  :url => entry.url,
                                  :section_name => feed[:section]
        article.save
        REDIS.expireat article.key, (article.published + 2.days).to_i
      end
    end
  end
end
