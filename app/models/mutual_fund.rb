class MutualFund < Security
  attr_accessible :scheme
  alias_attribute :scheme, :name

  validates :name,  :presence => true,
                    :uniqueness => true

  belongs_to :user

  delegate :securitycode, :scheme_class_description, :to => :scheme_master, :allow_nil => true
  delegate :nav_amount, :to => :navcp, :allow_nil => true

  alias :category :scheme_class_description

  def scheme_master
    Scheme.where(:scheme_name => scheme).first
  end

  def navcp
    Navcp.where(:security_code => securitycode).first
  end

  def current_value(transaction)
    nav_amount || transaction.net_position.transactions.last.price
  end

  def current_price
    nav_amount
  end
end
