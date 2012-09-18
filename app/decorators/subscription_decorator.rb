class SubscriptionDecorator < ApplicationDecorator
  decorates :subscription

  def render_user(size = :small)
    return unless user
    render_subscribable ProfileDecorator.decorate(user), size
  end

  def render_profile(size = :small)
    return unless subscribable_type == 'User'
    render_subscribable ProfileDecorator.decorate(subscribable), size
  end

  def render_portfolio(size = :small)
    return unless subscribable_type == 'Portfolio'
    render_subscribable PublicPortfolioDecorator.decorate(subscribable), size
  end

  def action_button(size = :small)
    if model.persisted?
      h.link_to h.subscription_path(model), :method => :delete, :class => ['btn', 'btn-danger', "btn-#{size}"] do
        h.content_tag(:i, nil, :class => %w(icon-eye-close icon-white)) + 'Unfollow'
      end
    else
      h.link_to h.subscriptions_path(:subscription => model.attributes.extract!('subscribable_type', 'subscribable_id')), :method => :post, :class => ['btn', 'btn-success', "btn-#{size}"] do
        h.content_tag(:i, nil, :class => %w(icon-eye-open icon-white)) + 'Follow'
      end
    end
  end

private
  def render_subscribable(subscribable, size = :small)
    image = h.content_tag :div, subscribable.avatar(size), :class => :span2
    name = h.content_tag :div, subscribable.link, :class => :span6
    unfollow_button = h.content_tag :div, subscribable.follow_unfollow_button(size), :class => %w(span4 align-right)
    h.content_tag :div, image + name + unfollow_button, :class => 'row-fluid'
  end
end
