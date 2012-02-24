class MutualFund < Security
  attr_accessible :scheme
  alias_attribute :scheme, :name

  belongs_to :user

  delegate :securitycode, :to => :scheme_master, :allow_nil => true
  delegate :nav_amount, :to => :mfnav_detail, :allow_nil => true

  def scheme_master
    SchemeMaster.where(:scheme_name => scheme).first
  end

  def mfnav_detail
    MfnavDetail.where(:security_code => securitycode).first
  end

  def current_value(transaction)
    nav_amount || transaction.net_position.transactions.last.price
  end
end
