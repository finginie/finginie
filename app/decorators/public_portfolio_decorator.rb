class PublicPortfolioDecorator < ApplicationDecorator
  decorates :portfolio

  def avatar(size = :small)
    h.image_tag 'portfolio_icon', :class => "avatar_#{size}"
  end

  def follow_unfollow_button(size = :small)
    return if model.user == h.current_user
    if subscription && subscription.persisted?
      h.link_to h.subscription_path(subscription), :method => :delete, :class => ['btn', 'btn-danger', "btn-#{size}"] do
        h.content_tag(:i, nil, :class => %w(icon-eye-close icon-white)) + 'Unfollow'
      end
    else
      h.link_to h.subscriptions_path(:subscription => subscription.attributes.extract!('subscribable_type', 'subscribable_id')), :method => :post, :class => ['btn', 'btn-success', "btn-#{size}"] do
        h.content_tag(:i, nil, :class => %w(icon-eye-open icon-white)) + 'Follow'
      end
    end
  end

  def link
    h.link_to_unless_current name, h.public_portfolio_path(model)
  end

private
  def subscription
    @subscription ||= model.subscriptions.where(:user_id => h.current_user.id).first_or_initialize
  end
end
