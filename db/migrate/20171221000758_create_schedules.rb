class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.integer :donor_id
      t.integer :member_id
      t.boolean :sent_status

      t.timestamps
    end
  end
end
