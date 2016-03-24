class CreateSlackSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_settings do |t|
      t.string :bot_access_token
      t.string :bot_user_id
      t.string :team_id

      t.timestamps
    end
  end
end
