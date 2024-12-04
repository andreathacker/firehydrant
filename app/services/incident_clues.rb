class IncidentClues
  def initialize(fire_hydrant_api: FireHydrantApi)
    @fire_hydrant_api = fire_hydrant_api
  end

  def self.build
    IncidentClues.new(
      fire_hydrant_api: FireHydrantApi.build
    )
  end

  def show(incident_id)
    @fire_hydrant_api.get_incident_events(incident_id)
  end
end
