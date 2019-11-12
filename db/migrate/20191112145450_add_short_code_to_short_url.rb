class AddShortCodeToShortUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :short_urls, :short_code, :string
  end
end
