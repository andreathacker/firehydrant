class IncidentClues
  def initialize(fire_hydrant_api: FireHydrantApi, clue_model: Clue)
    @fire_hydrant_api = fire_hydrant_api
    @clue_model = clue_model
  end

  def self.build
    IncidentClues.new(
      fire_hydrant_api: FireHydrantApi.build,
      clue_model: Clue
    )
  end

  def list_clues(incident_id)
    incident_events = @fire_hydrant_api.get_incident_events(incident_id)["data"]

    event_clues = []
    incident_events.each do |event|
      if @clue_model.exists?(event_id: event["id"])
        event_clues.append(event)
      end
    end

    event_clues
  end
end
