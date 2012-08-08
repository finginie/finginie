module PointTracker
  class SignUpStep < Base
    DESCRIPTION = 'Sign up'
    ACTION_LINK = '#'
    POINTS      = 100

    def valid?
      !completed_step_for_user?
    end
  end
end