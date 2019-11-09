# frozen_string_literal: true

class ShortUrls::RedirectController < ApplicationController
  def call
    @short_url = short_url_from_code

    if @short_url
      render 'redirecting'
    else
      render plain: error_message, status: :bad_request
    end
  end

  private

  def short_url_from_code
    ShortUrl.find_from_code(params[:short_code])
  end

  def error_message
    "Oops, the link you have followed looks invalid."
 end
end
