class IncidentsCluesController < ApplicationController
  def index
    incident_id = params[:incident_id]
    incident_clues = IncidentClues.build
    response = incident_clues.list_clues(incident_id)
    render json: response[0], status: response[1]
  end

  def create
    incident_id = params[:incident_id]
    body = JSON.parse(request.body.read)
    incident_clues = IncidentClues.build
    response = incident_clues.create_clue(incident_id, body)
    render json: response[0], status: response[1]
  end
end
