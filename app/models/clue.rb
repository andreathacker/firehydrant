# == Schema Information
#
# Table name: clues
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :uuid             not null
#  incident_id :uuid             not null
#
# Indexes
#
#  index_clues_on_event_id     (event_id) UNIQUE
#  index_clues_on_incident_id  (incident_id) UNIQUE
#
class Clue < ApplicationRecord
end
