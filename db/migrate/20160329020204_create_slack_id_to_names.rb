class CreateSlackIdToNames < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_id_to_names do |t|
      t.string :slack_id
      t.string :name

      t.timestamps
    end
  end
end
