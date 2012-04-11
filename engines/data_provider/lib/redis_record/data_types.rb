module RedisRecord::DataTypes
  extend ActiveSupport::Concern
  module ClassMethods
    def create_initializer(type, klass, defaults = {})
      define_singleton_method(type) do | *list, opts |
        unless opts.is_a? Hash
          list << opts
          opts = {}
        end
        opts[:type] ||= klass

        list.each do |attr|
          attribute attr, defaults.merge(opts)
        end
      end
    end
  end

  included do
    [ :integer, :boolean, :string ].each { |klass| create_initializer klass, klass.to_s.classify.constantize }
    create_initializer(:datetime, DateTime)
    create_initializer(:decimal, BigDecimal)
  end
end
