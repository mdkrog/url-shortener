class ShortUrlsController < ApplicationController
  before_action :requires_application_json_content_type, only: [:create]

  def show
    url = Rails.cache.read(params[:short_url])

    if url
      redirect_to url, :status => 301
    else
      render status: 404
    end
  end

  def create
    # binding.pry
    short_url = ShortUrl.new.call(params[:url])
    render json: {short_url: "/#{short_url}", url: params[:url]}
  end
end