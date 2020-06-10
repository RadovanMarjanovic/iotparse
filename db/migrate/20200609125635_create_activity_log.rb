class CreateActivityLog < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_logs do |t|
      t.integer :user_id
      t.string :activity
      t.string :browser
      t.string :ip_addres
      t.timestamps
    end
  end
end
