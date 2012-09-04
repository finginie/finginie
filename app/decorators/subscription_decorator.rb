class SubscriptionDecorator < ApplicationDecorator
  decorates :subscription

  def render_user
    render_person user if user
  end

  def render_profile
    render_person subscribable if subscribable_type == 'User'
  end

private
  def render_person(person)
    image = h.image_tag person.avatar_url
    name = h.content_tag :h6, person.name
    h.content_tag :div, (image + name)
  end
end
