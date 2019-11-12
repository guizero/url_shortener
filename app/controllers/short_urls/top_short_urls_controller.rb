# frozen_string_literal: true

class ShortUrls::TopShortUrlsController < ApplicationController
  def call
    @short_urls = ShortUrl.order(visits_count: :desc).limit(100)

    render 'top_short_urls'
  end
end
