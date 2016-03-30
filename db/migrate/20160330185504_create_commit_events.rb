class CreateCommitEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :commit_events do |t|
      t.string :author
      t.string :committer
      t.string :repository
      t.string :organization
      t.string :message
      t.string :added_files
      t.string :removed_files
      t.string :modified_files

      t.timestamps
    end
  end
end
