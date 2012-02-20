class User < ActiveRecord::Base
  attr_accessible :email
  attr_accessible :name, :avatar_url, :location, :occupation, :company    # Profile Attributes

  has_many :authentications

  has_many :portfolios
  has_one :financial_planner

  has_many :subscriptions, :dependent => :destroy
  has_many :follows, :dependent => :destroy,
           :as => :subscribable, :class_name => 'Subscription'

  has_one :comprehensive_risk_profiler

  def self.find_or_create_by_omniauth(auth_hash)
    authentication = Authentication
                        .where(:provider => auth_hash[:provider], :uid => auth_hash[:uid])
                        .first_or_create(:user => User.create(:email => auth_hash[:info][:email]))
    authentication.user
  end

  def merge_comprehensive_risk_profiler(attributes)
    attributes.delete("user_id")
    ComprehensiveRiskProfiler.find_or_initialize_by_user_id(self.id)
      .update_attributes(attributes)
    self
  end

  def comprehensive_risk_profiler
    super || build_comprehensive_risk_profiler
  end
end
