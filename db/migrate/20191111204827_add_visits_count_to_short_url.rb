class AddVisitsCountToShortUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :short_urls, :visits_count, :integer, default: 0
  end
end
