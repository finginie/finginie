module ActiveModelObject
  extend ActiveSupport::Concern

  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveModel::Serializers::JSON
  include ActiveModel::MassAssignmentSecurity
  extend ActiveModel::Naming

  included do
    alias :attributes= :update_attributes
  end
end
