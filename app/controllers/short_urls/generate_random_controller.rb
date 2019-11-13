# frozen_string_literal: true

class ShortUrls::GenerateRandomController < ApplicationController
  def call
    urls = FetchUrlsFromSearchService.call(params[:search_string]) || []

    if urls.size.positive?
      create_and_broadcast(urls)

      render json: { message: :success }, status: :ok
    else
      render json: { errors: ['Error generating short urls'] }, status: :bad_request
    end
  end

  private

  def create_and_broadcast(url_group)
    BatchCreateShortUrlsService.call(url_group)

    ActionCable.server.broadcast(
      'top_short_urls:top_short_url_channels',
      ShortUrl.order(visits_count: :desc).limit(100)
    )
  end
end
