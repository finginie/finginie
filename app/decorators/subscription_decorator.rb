class SubscriptionDecorator < ApplicationDecorator
  decorates :subscription

  def render_user(size = :big)
    render_person user if user
  end

  def render_profile(size = :big)
    render_person subscribable if subscribable_type == 'User'
  end

private
  def render_person(person, size = :big)
    person = ProfileDecorator.decorate person
    image = h.image_tag person.avatar_url, :class => size
    name = h.content_tag :h6, person.name, :class => size
    h.content_tag :div, (image + name)
  end
end
