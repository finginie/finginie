module PointTracker
  class Base
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def valid?
      true
    end

    def save(meta_data = {})
      CompletedStep.create({
        :step       => step_name,
        :user_id    => user.id,
        :meta_data => meta_data
      }) if valid?
    end

    def completed_step_for_user?
      CompletedStep.where({
        :step    => step_name,
        :user_id => user.id
      }).present?
    end

    def number_of_times_done
      CompletedStep.where({
        :step    => step_name,
        :user_id => user.id
      }).count
    end

    def total_points
      number_of_times_done * self.class.const_get('POINTS')
    end

    private
    def step_name
      self.class.name.split("::").last.underscore
    end
  end
end