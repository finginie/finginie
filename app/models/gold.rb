class Gold < Security
  belongs_to :user

  def current_value(transaction)
    current_price
  end

  def current_price
    @current_price || 2858.5
  end
end
