require 'redis_record'

class NewsArticle < RedisRecord
  string :id, :summary, :section_name, :source, :url
  has_value :published, :klass => Time

  def self.feeds
    all
      .sort_by(&:published)
      .group_by(&:section_name)
  end
end
