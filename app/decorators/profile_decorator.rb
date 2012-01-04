class ProfileDecorator < ApplicationDecorator
  decorates :user

  def follow_unfollow_button
    being_followed? ? unfollow_button : follow_button unless user == h.current_user
  end

  def being_followed?
    @being_followed ||= user.follows.find_by_user_id(h.current_user.id)
  end

  def follow_button
    h.simple_form_for subscription do |f|
      h.concat f.input :subscribable_id, :as => :hidden
      h.concat f.input :subscribable_type, :as => :hidden
      h.concat f.submit 'Follow'
    end
  end

  def unfollow_button
    h.button_to 'Unfollow', subscription, :method => :delete
  end

private
  def subscription
    @subscription ||= being_followed? || user.follows.new
  end
end
