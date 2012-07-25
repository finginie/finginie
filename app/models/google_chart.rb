class GoogleChart

  attr_accessor :data, :header

  def initialize(options = {})
    @data = options[:data]
    @header = options[:header]
  end

  def data
    raise 'Not a valid 2D array. data element is missing' unless @data.map(&:count).uniq.count == 1
    @data.map{|items| items.map{|item| items.first == item ? item.to_s : item.to_f }}
  end

  def elements
    [header] + data
  end

  def header
    raise 'Not a valid header array. data element and header count mismatch' if @header && @header.count != data.map(&:count).max
    @header || data.last.map {''}
  end
end
