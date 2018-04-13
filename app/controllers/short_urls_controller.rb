class ShortUrlsController < ApplicationController
  def show
    short_url = ShortUrl.find_by(short_url: params[:short_url])

    if short_url.present?
      redirect_to short_url.original_url
    else
      render plain: 'URL Not Found', status: 404
    end
  end
end
