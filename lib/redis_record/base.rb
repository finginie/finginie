module RedisRecord::Base
  extend ActiveSupport::Concern

  module InstanceMethods
    def save
      success = REDIS.multi do
        REDIS.set(key, to_json)
        sorted_indices.each do |attr|
          REDIS.zadd self.class.key(attr), attributes[attr], id
        end
      end
      self.persisted = (success.first == "OK")
    end

    def key
      self.class.key(id)
    end

    def update_attributes(attrs)
      super(attrs)
      save
    end
  end

  module ClassMethods
    def find(id)
      return nil unless json = REDIS.get(key id)
      self.new(ActiveSupport::JSON.decode(json)['attributes']).tap { |r| r.persisted = true }
    end

    def find_or_initialize_by_id(id)
      find(id) || self.new(:id => id)
    end

    def search_by_range_on(attr)
      self.sorted_indices += [attr]
      define_singleton_method "find_ids_by_#{attr}" do |min, max|
        REDIS.zrangebyscore(key(attr), min, max).map(&:to_i)
      end
    end

    def key(id)
      [model_name, id].join ':'
    end
  end

  included do
    boolean :persisted, :default => false
  end
end
