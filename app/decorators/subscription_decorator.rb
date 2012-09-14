class SubscriptionDecorator < ApplicationDecorator
  decorates :subscription

  def render_user(size = :small)
    render_person user, size if user
  end

  def render_profile(size = :small)
    return unless subscribable_type == 'User'
    render_person subscribable, size
  end

  def render_portfolio(size = :small)
    return unless subscribable_type == 'Portfolio'
    portfolio = PublicPortfolioDecorator.decorate subscribable
    image = h.content_tag :div, portfolio.avatar(size), :class => :span2
    name = h.content_tag :div, portfolio.link, :class => :span6
    unfollow_button = h.content_tag :div, portfolio.follow_unfollow_button(size), :class => %w(span4 align-right)
    h.content_tag :div, image + name + unfollow_button, :class => 'row-fluid'
  end

private
  def render_person(person, size = :small)
    person = ProfileDecorator.decorate person
    image = h.content_tag :div, person.avatar(size), :class => :span2
    name = h.content_tag :div, person.link, :class => :span6
    unfollow_button = h.content_tag :div, person.follow_unfollow_button(size), :class => %w(span4 align-right)
    h.content_tag :div, image + name + unfollow_button, :class => 'row-fluid'
  end
end
