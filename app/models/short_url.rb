# frozen_string_literal: true

class ShortUrl < ApplicationRecord
  validates :long_url, presence: true, length: { in: 5..2000 }
  validate :long_url_must_be_valid

  class << self
    def find_from_code(short_code)
      return nil unless ShortCode.valid?(short_code)

      find_by_id(ShortCode.decode(short_code))
    end
  end

  def short_code
    ShortCode.encode(id)
  end

  private

  def long_url_must_be_valid
    return if long_url&.match?(valid_uri_regexp)

    errors.add(:base, 'The provided URL is not valid')
  end

  def valid_uri_regexp
    URI::DEFAULT_PARSER.make_regexp(%w[http https])
  end
end
