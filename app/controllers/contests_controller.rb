class ContestsController < ApplicationController
  def index
    @contests = Contest.order(created_at: :desc).all
  end

  def show
    id = params[:id]
    @contest = Contest.find(id)
    @clients = Client.all
  end

  def destroy
    
  end

  def update
    
  end

  def create
    user = User.find(params[:contest][:user_id])
    user.contests.create(contest_parameters)
    redirect_to contests_path
  end

  def contest_parameters
    params.require(:contest).permit(:name, :description, :media, :url, :start_date, :end_date, :award_description)
  end

  def edit
    @contest = Contest.find(params[:id])
  end
end
