class VideosController < ApplicationController
  def upload

  end

  private

  def video_params
    params.require(:video).permit(:first_name, :last_name, :email, :message, :file)
  end
end
