class CreateMentionEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :mention_events do |t|
      t.string :mentioned_id
      t.references :slack_message, foreign_key: true

      t.timestamps
    end
  end
end
