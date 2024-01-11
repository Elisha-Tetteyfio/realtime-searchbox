class CreateSearchRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :search_records do |t|
      t.string :query
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
