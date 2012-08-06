class Step < ActiveRecord::Base
  attr_accessible :name, :points

  #Note:: These numbers below are the ids for the steps table, these ids are given in seeds
  FINANCIAL_PROFILE_QUIZ                  = 1
  SIGN_UP                                 = 2
  FACEBOOK_LIKE                           = 3
  SHARE_FINANCIAL_PROFILE_ON_FB           = 4
  SHARE_FINANCIAL_PROFILE_ON_TWITTER      = 5
  SHARE_FINANCIAL_PROFILE_ON_EMAIL        = 6
  SIGN_UP_FOR_TRADING                     = 7
  REFERRAL                                = 8
  NEW_TRADKING_ACCOUNT_FROM_SHARED_LINK   = 9
end
