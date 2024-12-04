class ClueService
  def initialize(clue_model: Clue)
    @clue_model = clue_model
  end

  def create(incident_id, event_id)
    clue = @clue_model.new(
      incident_id: incident_id,
      event_id: event_id
    )
    clue.save
    clue
  end

  def show(id)
    @clue_model.find(id)
  end

  def show_incident_clues(incident_id)
    @clue_model.where(incident_id: incident_id)
  end
end
