class IncidentClues
  def initialize(fire_hydrant_api: FireHydrantApi)
    @fire_hydrant_api = fire_hydrant_api
  end

  def self.build
    IncidentClues.new(
      fire_hydrant_api: FireHydrantApi.build
    )
  end

  def index(incident_id)
    incident_events = @fire_hydrant_api.get_incident_events(incident_id)["data"]

    event_clues = []
    incident_events.each do |event|
      if Clue.exists?(event_id: event["id"])
        event_clues.append(event)
      end
    end

    event_clues
  end
end
