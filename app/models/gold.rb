class Gold < Security
  belongs_to :user

  def current_value(transaction)
    current_price
  end
end

