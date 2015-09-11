class ContestController < ApplicationController
  def index
    if session[:user_logged_id] != nil
      user_id = session[:user_logged_id]
      @contests = Contest.where(:user_id => user_id).order(created_at: :desc);
    else
      @contests = Contest.order(created_at: :desc).all;
    end

  end

  def browse
    @contests = Contest.order(created_at: :desc).all
  end

  def new
  end

  def create
    user = User.find(params[:contest][:user_id])
    user.contests.create(contest_parameters)
    redirect_to root_path
  end

  def destroy
    
  end

  private

  def contest_parameters
    params.require(:contest).permit(:name, :description, :media, :url, :start_date, :end_date, :award_description)
  end

  def show(id)
    @contest = Contest.find(id)
  end

end
