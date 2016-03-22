class CreateIssueEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :issue_events do |t|
      t.string :action
      t.string :name
      t.string :actor
      t.string :repository
      t.string :organization
      t.integer :number

      t.timestamps
    end
  end
end
