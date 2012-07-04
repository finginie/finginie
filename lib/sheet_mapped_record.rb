class SheetMappedRecord
  include ActiveAttr::Model

  def self.all
    self.items
  end

  def self.filter(params)
    query = params[:query]
    params.keys.include?(:nse_code) ? self.all.select { |r| r.nse_code == params[:nse_code] } :
      query ? self.all.select { |r| r.source.include?(query) || r.company_name.include?(query) ||
                            r.sector.include?(query) } : self.all
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
      attributes = {}; r.attributes.each {|k,v| attributes[k] = v.strip }
      self.new attributes
    end
  end
end
