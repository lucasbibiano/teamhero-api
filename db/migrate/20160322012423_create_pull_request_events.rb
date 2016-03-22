class CreatePullRequestEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :pull_request_events do |t|
      t.string :action
      t.string :name
      t.string :actor
      t.string :repository
      t.string :organization
      t.integer :number
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
