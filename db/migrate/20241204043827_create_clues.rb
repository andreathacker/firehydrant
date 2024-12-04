class CreateClues < ActiveRecord::Migration[8.0]
  def change
    create_table :clues, id: :uuid do |t|
      t.uuid :incident_id, null: false
      t.uuid :event_id, null: false

      t.timestamps
    end

    add_index :clues, :incident_id, unique: true
    add_index :clues, :event_id, unique: true
  end
end
