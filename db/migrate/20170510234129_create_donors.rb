class CreateDonors < ActiveRecord::Migration[5.0]
  def change
    create_table :donors do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :donation
      t.string :campaign_name
      t.string :affiliate
      t.string :secure_id
      t.string :campaign_slug
      t.string :key

      t.timestamps
    end
  end
end
