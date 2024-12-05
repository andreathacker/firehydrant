class IncidentClues
  def initialize(fire_hydrant_api: FireHydrantApi.build, clue_model: Clue)
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
    if incident_id.blank?
      return [
        { error: "Invalid incident_id" },
        :bad_request
      ]
    end

    incident_events = @fire_hydrant_api.get_incident_events(incident_id)["data"]

    event_clues = []
    incident_events.each do |event|
      if @clue_model.exists?(event_id: event["id"])
        event_clues.append(event)
      end
    end
    [
      { data: event_clues },
      :ok
    ]
  rescue => e
    Rails.logger.error(e)
    [
      { error: "Internal server error" },
      :internal_server_error
    ]
  end
end
