module ActiveModelObject
  extend ActiveSupport::Concern

  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveModel::Serializers::JSON
  include ActiveModel::MassAssignmentSecurity
  extend ActiveModel::Naming

  module ClassMethods
    def attr_accessible(*args)
      super
      attr_accessor *args
    end
  end

  module InstanceMethods
    def initialize(hash = {})
      attributes = hash
      @persisted = false
    end

    def persisted?
      @persisted
    end

  protected

    def attributes=(hash)
      sanitize_for_mass_assignment(hash).each do |k, v|
        instance_variable_set("@#{k}", v)
      end
    end

    def attributes
      sanitize_for_mass_assignment(instance_values)
    end unless method_defined?(:attributes)

  end
end
