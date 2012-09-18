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

  def portfolio_hide_content
    "#{user_link} made the portfolio #{target.name} private.".html_safe
  end

  def new_subscription_content
    "#{user_link} is now following #{target_link}".html_safe
  end

  def gold_buy_content
    "#{target_link} portfolio: #{user_link} has bought gold at Rs.#{data['price']} per gm.".html_safe
  end

  def gold_sell_content
    "#{target_link} portfolio: #{user_link} has sold gold at Rs.#{data['price']} per gm.".html_safe
  end

  def mutual_fund_buy_content
    "#{target_link} portfolio: #{user_link} has invested in #{mutual_fund_link} scheme at Rs.#{data['price']}".html_safe
  end

  def mutual_fund_sell_content
    "#{target_link} portfolio: #{user_link} has sold #{mutual_fund_link} at Rs.#{data['price']}".html_safe
  end

  def stock_buy_content
    "#{target_link} portfolio: #{user_link} has invested in #{stock_link} shares at Rs.#{data['price']} per share.".html_safe
  end

  def stock_sell_content
    "#{target_link} portfolio: #{user_link} has sold #{stock_link} at Rs.#{data['price']} per share.".html_safe
  end

  def user_link(profile = user)
    h.link_to profile.slug_name, h.profile_path(profile)
  end

  def target_link
    case target_type
    when 'Portfolio'
      public_portfolio_link
    when 'User'
      user_link target
    else
      target.name
    end
  end

  def public_portfolio_link
    h.link_to target.name, h.public_portfolio_path(target)
  end

  def mutual_fund_link
    h.link_to data['name'], h.mutual_fund_path(:id => data['param'])
  end

  def stock_link
    h.link_to data['name'], h.stock_path(:id => data['param'])
  end
end
