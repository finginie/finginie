require 'redis_record'

class NewsArticle < RedisRecord
  string :id, :summary, :section_name, :source, :url
  has_value :published, :klass => Time
  integer :published_time

  search_by_range_on :published_time

  def self.get_feeds
    find_ids_by_published_time(2.days.ago.to_i , Time.now.to_i)
      .map { |i| find(i) }
      .sort_by(&:published_time)
      .group_by(&:section_name)
  end

end
