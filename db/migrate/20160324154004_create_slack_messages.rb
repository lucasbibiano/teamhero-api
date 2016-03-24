class CreateSlackMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_messages do |t|
      t.string :channel_id
      t.string :team_id
      t.text :body
      t.string :actor
      t.boolean :shared_link

      t.timestamps
    end
  end
end
