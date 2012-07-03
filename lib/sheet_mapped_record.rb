class SheetMappedRecord
  include ActiveAttr::Model

  def self.all
    @records ||= self.collection.records
  end

  def self.collection
    @collection ||= begin
      collection = SPREADSHEET.find_collection_by_title table_name
      collection.instance_variable_set :@mapper, mapper
      collection
    end
  end

  def self.table_name
    name.underscore
  end

  def self.mapper
    @mapper ||= Class.new SheetMapper::Base
  end
end
