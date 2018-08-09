class ShortUrlsController < ApplicationController
  def show
    url = Rails.cache.read(params[:short_url])

    if url
      redirect_to url, :status => 301
    else
      render status: 404
    end
  end

  def create
    render json: {}
  end
end