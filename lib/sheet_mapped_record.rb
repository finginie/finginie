class SheetMappedRecord
  include ActiveAttr::Model

  def self.all
    self.items
  end

  def self.filter(param)
    param = param || ''
    self.all.select { |r| r.source.include?(param) ||
                          r.company_name.include?(param) ||
                          r.sector.include?(param) }
  end

private
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
    @mapper ||= Class.new SheetMapper::Base do
      def valid_row?
        self.pos > 1
      end
    end
    @mapper.instance_variable_set "@columns", self.attributes.keys
    @mapper
  end

  def self.items
    collection.map do |r|
      self.new r.attributes
    end
  end
end
