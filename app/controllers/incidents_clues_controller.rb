class IncidentsCluesController < ApplicationController
  def index
    incident_id = params[:incident_id]
    incident_clues = IncidentClues.build
    clues = incident_clues.list_clues(incident_id)
    render json: { "data": clues }
  end
end
