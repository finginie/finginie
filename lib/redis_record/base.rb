module RedisRecord::Base
  extend ActiveSupport::Concern

  module InstanceMethods
    def save
      self.persisted = (REDIS.set(key, to_json) == "OK")
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

    def key(id)
      [model_name, id].join ':'
    end
  end

  included do
    boolean :persisted, :default => false
  end
end
