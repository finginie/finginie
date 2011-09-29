class RiskProfileController < ApplicationController
  def show
    @quizzes = Quiz.all
  end
end
