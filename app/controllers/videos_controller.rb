class VideosController < ApplicationController
  def index
    videos = Video.all
    render json: videos.as_json(
      only: %i[
        id
        title
        release_date
        available_inventory
      ]
    ), status: :ok
  end

  def show
  end

  def create
    video = Video.new(video_params)

    if video.save
      render json: video.as_json(only: [:id]), status: :created
      return
    else
      render json: {
          ok: false,
          errors: video.errors.messages
      }, status: :bad_request
      return
    end

  end

  private

  def video_params
    return params.permit(:id, :title, :overview, :release_date, :total_inventory, :available_inventory)
  end
end
