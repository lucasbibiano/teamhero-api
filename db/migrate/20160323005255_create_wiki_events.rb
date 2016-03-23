class CreateWikiEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :wiki_events do |t|
      t.string :organization
      t.string :repository
      t.string :actor
      t.text :pages

      t.timestamps
    end
  end
end
