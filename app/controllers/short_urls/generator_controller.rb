# frozen_string_literal: true

class ShortUrls::GeneratorController < ApplicationController
  def call
    if shortened_url.save
      render json: { id: shortened_url.id, short_code: shortened_url.short_code }, status: :ok
    else
      render json: { errors: shortened_url.errors }, status: :bad_request
    end
  end

  private

  def shortened_url
    @shortened_url ||= ShortUrl.new(
      long_url: params[:long_url].to_s
    )
  end
end
