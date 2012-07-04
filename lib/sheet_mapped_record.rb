class SheetMappedRecord
  include ActiveAttr::Model

  module ClassMethods
    def all
      items
    end

  private
    def collection
      @collection ||= begin
        collection = SPREADSHEET.find_collection_by_title table_name
        collection.instance_variable_set :@mapper, mapper
        collection
      end
    end

    def table_name
      name.underscore
    end

    def mapper
      @mapper ||= Class.new SheetMapper::Base do
        def valid_row?
          self.pos > 1
        end
      end
      @mapper.instance_variable_set "@columns", self.attributes.keys
      @mapper
    end

    def items
      collection.map do |r|
        attributes = {}; r.attributes.each {|k,v| attributes[k] = v.strip }
        self.new attributes
      end
    end
  end; extend ClassMethods
end
