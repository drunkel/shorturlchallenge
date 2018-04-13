class ShortUrlsController < ApplicationController

  def create
    @errors = []
    url = params[:url]

    service = ShortUrlPersistenceService.new(url)    
    begin
      @short_url = service.save!
    rescue StandardError
      @errors << 'Something went wrong. Please try again later.'
    end

    if service.errors.any?
      service.errors.each { |e| @errors << e }
    end

    render :index
  end

  def show
    short_url = ShortUrl.find_by(short_url: params[:short_url])

    if short_url.present?
      redirect_to short_url.original_url
    else
      render plain: 'URL Not Found', status: 404
    end
  end
end
