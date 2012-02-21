class MutualFund < Security
  attr_accessible :scheme
  alias_attribute :scheme, :name

  belongs_to :user

  def nav_amount
    securitycode = SchemeMaster.where(:scheme_name => scheme).first.securitycode
    MfnavDetail.where(:security_code => securitycode).first.nav_amount
  end

  def current_value(transaction)
    nav_amount
  end
end
