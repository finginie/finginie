class MutualFund < Security
  attr_accessible :scheme
  alias_attribute :scheme, :name

  validates :name,  :presence => true,
                    :uniqueness => true

  belongs_to :user

  delegate :security_code, :nav_amount, :class_description, :to => :scheme_master, :allow_nil => true

  alias :category :class_description

  def scheme_master
    Scheme.where(:name => scheme).first
  end

  def current_value(transaction)
    nav_amount || transaction.net_position.transactions.last.price
  end

  def current_price
    nav_amount
  end
end
