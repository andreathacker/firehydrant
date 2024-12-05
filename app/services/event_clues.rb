class EventClues
  def initialize(
    fire_hydrant_api: FireHydrantApi.build,
    clue_model: Clue
  )
    @fire_hydrant_api = fire_hydrant_api
    @clue_model = clue_model
  end

  def add_clue(incident_id, event_id)
    c = @clue_model.create!(
      incident_id: incident_id,
      event_id: event_id
    )
    [
      {
        id: c.id,
        incident_id: c.incident_id,
        event_id: c.event_id
      },
      :ok
    ]
  rescue => e
    Rails.logger.error(e)
    [
      { error: "Internal server error #{e}" },
      :internal_server_error
    ]
  end
end