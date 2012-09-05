class ProfileDecorator < ApplicationDecorator
  decorates :user

  def avatar_url
    model.avatar_url || 'profile.png'
  end
end
