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

  def follow_unfollow_button(size = :small)
    return if model == h.current_user
    if subscription && subscription.persisted?
      h.link_to h.subscription_path(subscription), :method => :delete, :class => ['btn', 'btn-danger', "btn-#{size}"] do
        h.content_tag(:i, nil, :class => %w(icon-eye-close icon-white)) + 'Unfollow'
      end
    else
      h.link_to h.subscriptions_path(:subscription => subscription.attributes.extract!('subscribable_type', 'subscribable_id')), :method => :post, :class => ['btn', 'btn-danger', "btn-#{size}"] do
        h.content_tag(:i, nil, :class => %w(icon-eye-open icon-white)) + 'Follow'
      end
    end
  end

private
  def subscription
    @subscription ||= model.follow_subscriptions.where(:user_id => h.current_user.id).first_or_initialize
  end
end
