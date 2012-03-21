class Gold
  def self.current_price
    @current_price ||= REDIS.get("gold:current_price").to_i
  end

  def self.current_price=(price)
    REDIS.set("gold:current_price", @current_price = price).to_i
  end
end

