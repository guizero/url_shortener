# frozen_string_literal: true

class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.references :short_url
      t.string :ip, null: false, limit: 15

      t.timestamps
    end

    add_index :visits, [:short_url_id, :ip], unique: true
  end
end