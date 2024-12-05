class RemoveUniqueIndexFromIncidentIdOnClues < ActiveRecord::Migration[8.0]
  def change
    remove_index :clues, column: :incident_id, unique: true
  end
end
