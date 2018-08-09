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
    short_url = ShortUrl.new.call(params[:url])
    render json: {short_url: "/#{short_url}", url: params[:url]}
  end
end