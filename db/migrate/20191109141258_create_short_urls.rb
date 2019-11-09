class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :short_urls do |t|
      t.string :long_url, null: false, limit: 2000

      t.timestamps
    end
  end
end
