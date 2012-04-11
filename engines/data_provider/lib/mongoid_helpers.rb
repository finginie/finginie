module MongoidHelpers
  def find_and_update_attributes(attributes)
    keys = attributes.extract! *primary_key
    find_or_initialize_by(keys).update_attributes(attributes)
  end
end
