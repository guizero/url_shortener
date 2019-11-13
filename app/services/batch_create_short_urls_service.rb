# frozen_string_literal: true

class BatchCreateShortUrlsService
  def self.call(urls)
    new.call(urls)
  end

  def call(urls)
    urls.each do |url|
      populate(url)
    end
  end

  private

  def populate(url)
    create_short_url(url)
  end

  def create_short_url(url)
    ShortUrl.create(long_url: url, visits_count: rand(1..5000))
  end
end
