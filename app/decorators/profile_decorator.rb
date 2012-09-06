class ProfileDecorator < ApplicationDecorator
  decorates :user

  def avatar_url
    model.avatar_url || 'profile.png'
  end

  def follow_unfollow_button
    if subscription && subscription.persisted?
      h.link_to h.subscription_path(subscription), :method => :delete, :class => %w(btn btn-danger) do
        h.content_tag(:i, nil, :class => %w(icon-eye-close icon-white)) + 'Stop Following'
      end
    else
      h.link_to h.subscriptions_path(:subscription => subscription.attributes.extract!('subscribable_type', 'subscribable_id')), :method => :post, :class => %w(btn btn-success) do
        h.content_tag(:i, nil, :class => %w(icon-eye-open icon-white)) + 'Follow'
      end
    end
  end

private
  def subscription
    @subscription ||= model.follow_subscriptions.where(:user_id => h.current_user.id).first_or_initialize
  end
end
