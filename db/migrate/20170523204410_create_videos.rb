class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :link
      t.string :title
      t.string :uid
      t.string :file
      t.text :description
      t.references :donor, foreign_key: true

      t.timestamps
    end
    add_index :videos, :uid
  end
end
