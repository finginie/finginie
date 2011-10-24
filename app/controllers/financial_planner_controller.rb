class FinancialPlannerController < ApplicationController
  def show
    @quizzes = Quiz.all
  end
end
