class PointTrackerDecorator < ApplicationDecorator
  decorates 'point_tracker/financial_profile_quiz'
  decorates 'point_tracker/referral'
  decorates 'point_tracker/share_financial_profile_on_fb'
  decorates 'point_tracker/sign_up'

  def table_row
    h.content_tag(:tr, :class => 'a') do
      completed_table_data       +
      description_table_data     +
      points_per_step_table_data +
      number_of_times_table_data +
      total_points_table_data
    end
  end

  private
  def step_klass
    model.class
  end

  def completed_table_data
    h.content_tag(:td, (model.completed_step_for_user? ? 'Yes' : 'No'))
  end

  def description_table_data
    h.content_tag(:td, h.link_to(step_klass.const_get('DESCRIPTION'), step_klass.const_get('ACTION_LINK')))
  end

  def points_per_step_table_data
    h.content_tag(:td, step_klass.const_get('POINTS'))
  end

  def number_of_times_table_data
    h.content_tag(:td, model.number_of_times_done)
  end

  def total_points_table_data
    h.content_tag(:td, model.total_points)
  end
end