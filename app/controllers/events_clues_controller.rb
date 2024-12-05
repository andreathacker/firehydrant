class EventsCluesController < ApplicationController
  def create
    incident_id = params[:incident_id]
    event_id = params[:event_id]
    event_clues = EventClues.new
    response = event_clues.add_clue(incident_id, event_id)
    render json: response[0], status: response[1]
  end
end
