class ContestController < ApplicationController
  def index
  end

  def form
  end

  def create
    user = User.find(params[:contest][:user_id])
    user.contests.create(contest_parameters)
    redirect_to root_path
  end

  private

  def contest_parameters
    params.require(:contest).permit(:name, :description, :media, :url, :start_date, :end_date, :award_description)
  end
end
