class EventDecorator < ApplicationDecorator
  decorates :event

  def icon
    h.image_tag "#{action}_event_icon.png"
  end

  def title
    model.action.titleize
  end

  def content
    h.content_tag :p, send("#{action}_content")
  end

private
  def portfolio_share_content
    "#{user_link} made the portfolio #{public_portfolio_link} public.".html_safe
  end

  def user_link
    h.link_to user.slug_name, h.profile_path(user)
  end

  def public_portfolio_link
    h.link_to target.name, h.public_portfolio_path(target)
  end
end
