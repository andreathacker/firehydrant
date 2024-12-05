class IncidentsCluesController < ApplicationController
  def index
    incident_id = params[:incident_id]
    incident_clues = IncidentClues.build
    response = incident_clues.list_clues(incident_id)
    render json: response[0], status: response[1]
  end
  
  def create
    
  end
end
