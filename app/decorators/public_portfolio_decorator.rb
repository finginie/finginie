class PublicPortfolioDecorator < ApplicationDecorator
  decorates :portfolio

  def avatar(size = :small)
    h.image_tag 'portfolio_icon', :class => "avatar_#{size}"
  end

  def follow_unfollow_button(size = :small)
    return if model.user == h.current_user
    subscription.action_button
  end

  def link
    h.link_to_unless_current name, h.public_portfolio_path(model)
  end

private
  def subscription
    @subscription ||= begin
      subscription = model.subscriptions.where(:user_id => h.current_user.id).first_or_initialize
      SubscriptionDecorator.decorate subscription
    end
  end
end
