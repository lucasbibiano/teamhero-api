class CreateCommentEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_events do |t|
      t.integer :issue
      t.string :organization
      t.string :repository
      t.text :body
      t.string :actor

      t.timestamps
    end
  end
end
