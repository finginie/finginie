module RedisRecord::DataTypes
  extend ActiveSupport::Concern
  module ClassMethods
    def create_initializer(type, klass, defaults = {})
      define_singleton_method(type) do | *list, opts |
        unless opts.is_a? Hash
          list << opts 
          opts = {}
        end
        opts[:klass] ||= klass

        list.each do |attr|
          has_value attr, defaults.merge(opts)
        end
      end
    end
  end

  included do
    [ :integer, :decimal, :boolean, :string ].each { |klass| create_initializer klass, klass }
    create_initializer(:datetime, DateTime, :formatter => :parse)
  end
end
