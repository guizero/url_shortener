# frozen_string_literal: true

class Visit < ApplicationRecord
  belongs_to :short_url, counter_cache: true

  validates :ip,
            uniqueness: { scope: :short_url_id, case_sensitive: false },
            presence: true
end
