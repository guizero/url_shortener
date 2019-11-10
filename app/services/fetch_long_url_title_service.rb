# frozen_string_literal: true

require 'open-uri'

class FetchLongUrlTitleService
  def self.call(url)
    new.call(url)
  end

  def call(url)
    fetch_title(url).presence || 'Title not present or not found'
  end

  private

  def fetch_title(url)
    Nokogiri::HTML(open(url)).css('title').text
  rescue Errno::ENOENT, TypeError
    ''
  end
end
