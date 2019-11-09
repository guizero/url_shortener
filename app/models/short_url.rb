# frozen_string_literal: true

class ShortUrl < ApplicationRecord
  validates :long_url, presence: true, length: { in: 5..2000 }
  validate :long_url_must_be_valid

  private

  def long_url_must_be_valid
    return if long_url&.match?(valid_uri_regexp)

    errors.add(:base, 'The provided URL is not valid')
  end

  def valid_uri_regexp
    URI::DEFAULT_PARSER.make_regexp(%w[http https])
  end
end
