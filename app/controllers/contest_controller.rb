class ContestController < ApplicationController
  def index
    if session[:user_logged_id] != nil
      user_id = session[:user_logged_id]
      @contests = Contest.where(:user_id => user_id).order(created_at: :desc);
    else
      @contests = Contest.order(created_at: :desc).all;
    end

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
