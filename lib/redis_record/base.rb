module RedisRecord::Base
  extend ActiveSupport::Concern

  def ==(another)
    self.attributes == another.attributes
  end

  def save
    success = REDIS.multi do
      REDIS.set(key, to_json)
      sorted_indices.each do |attr|
        REDIS.zadd self.class.meta_key(attr), attributes[attr], id
      end
    end
    self.persisted = (success.first == "OK")
  end

  alias save! save

  def key
    self.class.key(id)
  end

  def update_attributes(attrs)
    super(attrs)
    save
  end

  def destroy
    success = REDIS.multi do
      REDIS.del key
      sorted_indices.each do |attr|
        REDIS.zrem self.class.meta_key(attr), id
      end
    end
    success.first == 1 ? self : nil
  end

  module ClassMethods
    def find(id)
      find_by_key key id
    end

    def find_by_key(key)
      return nil unless json = REDIS.get(key)
      self.new(ActiveSupport::JSON.decode(json)['attributes']).tap { |r| r.persisted = true }
    end

    def all
      REDIS.keys("#{model_name}:*").map { |key| find_by_key key }
    end

    def find_or_initialize_by_id(id)
      find(id) || self.new(:id => id)
    end

    def search_by_range_on(attr)
      self.sorted_indices += [attr]
      define_singleton_method "find_ids_by_#{attr}" do |min, max|
        REDIS.zrangebyscore(meta_key(attr), min, max).map { |id| Valuable::Utils.format(:id, id, _attributes) }
      end
    end

    def meta_key(attr)
      ['Meta', model_name, attr].join ':'
    end

    def key(id)
      [model_name, id].join ':'
    end
  end

  included do
    boolean :persisted, :default => false
  end
end
