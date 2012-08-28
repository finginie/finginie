module PointTracker
  class Base
    attr_reader :user, :meta_data

    def initialize(user, meta_data = {})
      @user = user
      @meta_data = meta_data
    end

    def valid?
      true
    end

    def save
      CompletedStep.create({
        :step       => step_name,
        :user_id    => user.id,
        :meta_data => meta_data
      }) if valid?
    end

    def completed_step_for_user?
      completed_steps.present?
    end

    def number_of_times_done
      completed_steps.count
    end

    def total_points
      number_of_times_done * self.class.const_get('POINTS')
    end

    private
    def completed_steps
      user.completed_steps.where(:step => step_name)
    end

    def step_name
      self.class.name.split("::").last.underscore
    end
  end
end