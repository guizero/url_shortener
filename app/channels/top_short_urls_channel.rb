# frozen_string_literal: true

class TopShortUrlsChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'top_short_url_channels'
  end

  def unsubscribed; end
end
