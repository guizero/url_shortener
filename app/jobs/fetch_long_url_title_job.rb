class FetchLongUrlTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url)
    short_url.update(title: FetchLongUrlTitleService.call(short_url.long_url))
  end
end
