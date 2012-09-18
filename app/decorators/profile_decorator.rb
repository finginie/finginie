class ProfileDecorator < ApplicationDecorator
  decorates :user

  def avatar_url
    model.avatar_url.present? ? model.avatar_url : 'profile.png'
  end

  def avatar(size = :small)
    h.image_tag avatar_url, :class => "avatar_#{size}"
  end

  def name
    model.name || model.slug_name
  end

  def link
    h.link_to_unless_current name, h.profile_path(model)
  end

  def follow_unfollow_button(size = :small)
    return if model == h.current_user
    subscription.action_button
  end

private
  def subscription
    @subscription ||= begin
      subscription = model.follow_subscriptions.where(:user_id => h.current_user.id).first_or_initialize
      SubscriptionDecorator.decorate subscription
    end
  end
end
