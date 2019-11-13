# frozen_string_literal: true

class FetchUrlsFromSearchService
  def self.call(search_string)
    new.call(search_string)
  end

  def call(search_string)
    # The idea here was to fetch from a serp api
    [
      'https://www.google.com',
      'http://lets.events',
      'http://www.xerpa.com.br',
      'http://www.globo.com',
      'http://www.rockcontent.com'
    ]*5
  end
end
