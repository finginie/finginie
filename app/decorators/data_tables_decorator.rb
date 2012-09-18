class DataTablesDecorator < Draper::DecoratedEnumerableProxy
  def method_missing(method, *args, &block)
    if @wrapped_collection.respond_to?(method)
      @wrapped_collection = @wrapped_collection.send(method, *args)
    else
      super
    end
    self
  end
end
