class FungiblePositionDecorator

  FIELDS_TO_NA = [ :current_price, :unrealised_profit, :unrealised_profit_percentage ]

  (FIELDS_TO_NA).each do |key|                        ##
    define_method(key.to_sym) do                      # def key
      return "-" unless @position.send(key)           #   return "-"
      @position.send(key)                             #   @position.key
    end                                               # end
  end                                                 ##

  def action_params
    params = { :quantity => @position.quantity, :action => :sell }
    params[:scheme] = @position.name if @position.respond_to?(:mutual_fund)
    params[:company_code] = @position.company.company_code if @position.respond_to?(:company)
    params
  end

  def initialize(position)
    @position = position
  end

  def self.custom_decorate(position)
    new(position)
  end

  def method_missing(method, *args, &block)
    if @position.respond_to?(method)
      @position.send(method)
    else
      super
    end
  end
end
