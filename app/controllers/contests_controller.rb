class ContestsController < ApplicationController

  require 'video_convert_job'

  def index
    @contests = Contest.all
  end

  def show
    #include_all_helpers
    id = params[:id]
    @contest = Contest.find(id)
    #@clients = Client.all
    @videos = Video.where(contest_id: id, video_status_id: 2).all
    @original_videos = Video.where(contest_id: id).all
  end

  def destroy
    id = params[:id]

    begin
      Contest.destroy(id)
      flash[:success] = "The contests was deleted"
    rescue => ex
      logger.error ex.message
      flash[:error] = "An error has occur trying to delete the contest [#{ex.message}]"
    end
    redirect_to '/mycontests'
  end

  def update
    begin
      contest = Contest.find(params[:id])
      contest.update(contest_parameters)
      flash[:success] = "The contest was updated successfully"
    rescue => ex
      logger.error ex.message
      flash[:error] = "An error has occur trying to update the contest"
    end

    redirect_to "/mycontests"
  end

  def create
    new_contest = contest_parameters
    new_contest.merge!(:start_date => "#{params[:contest]['start_date(1i)']}-#{params[:contest]['start_date(2i)']}-#{params[:contest]['start_date(3i)']}")
    new_contest.merge!(:end_date => "#{params[:contest]['end_date(1i)']}-#{params[:contest]['end_date(2i)']}-#{params[:contest]['end_date(3i)']}")
    Contest.create(contest_parameters)
    redirect_to "/mycontests"
  end

  def contest_parameters
    params.require(:contest).permit(:name, :description, :media, :url, :award_description, :user_id)
  end

  def edit
    @contest = Contest.find(params[:id])
  end

  def browse

  end

  def mycontests
    @contests = Contest.where(:user_id => session[:user_logged_id]).all
    render 'contests/index'
  end

  def upload_video
    contest = Contest.find(params[:video][:contest_id])
    begin
      Video.upload(video_params)
      flash[:success] = "The video was uploaded and is " + video_status.name + " we'll contact you as soon as the video is ready to watch"
    rescue => ex
      logger.error ex.message
      flash[:error] = ex.message
    end
    redirect_to contest
  end

  private

    def video_params
      params.require(:video).permit(:contest_id, :first_name, :last_name, :email, :message, :video)
    end


  def custom_url
    contest = Contest.where(url: params[:custom_url])[0]
    if contest != nil
      redirect_to contest
    else
      redirect_to root_path
    end
  end
end
