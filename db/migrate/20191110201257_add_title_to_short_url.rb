class AddTitleToShortUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :short_urls, :title, :string
  end
end
