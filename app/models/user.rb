class User < ActiveRecord::Base
  attr_accessible :email
  attr_accessible :name, :avatar_url, :location, :occupation, :company    # Profile Attributes

  has_many :portfolios, :dependent => :destroy

  has_many :subscriptions, :dependent => :destroy
  has_many :follows, :dependent => :destroy,
           :as => :subscribable, :class_name => 'Subscription'

  has_one :comprehensive_risk_profiler, :dependent => :destroy

  def self.find_or_create_by_omniauth(auth_hash)
    where(:id => auth_hash[:uid])
      .first_or_create(:email => auth_hash[:info][:email])
  end

  def merge_comprehensive_risk_profiler(attributes)
    return self if comprehensive_risk_profiler.persisted?
    attributes[:score_cache] ? comprehensive_risk_profiler.update_attribute(:score_cache, attributes[:score_cache]) : create_comprehensive_risk_profiler(attributes)
    self
  end

  def comprehensive_risk_profiler
    super || build_comprehensive_risk_profiler
  end
end
