class FungiblePositionDecorator

  FIELDS_TO_NA = [ :current_price, :unrealised_profit, :unrealised_profit_percentage ]
  FIELDS_TO_COLORIZE = [:unrealised_profit, :unrealised_profit_percentage]

  FIELDS_TO_NA.each do |key|                        ##
    define_method(key.to_sym) do                      # def key
      @position.send(key) || '-'                      #   @position.key || '-'
    end                                               # end
  end                                                 ##

  FIELDS_TO_COLORIZE.each do |key|
    define_method "#{key}_with_colorize" do
      if model.send(key)
        rg_colorize self.send("#{key}_without_colorize"), model.send(key)
      else
        self.send #{key}_without_colorize"
      end
    end
  end

  def action_params
    params = { :quantity => @position.quantity, :action => :sell }
    params[:scheme] = @position.name if @position.respond_to?(:mutual_fund)
    params[:company_code] = @position.company.code if @position.respond_to?(:company)
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
