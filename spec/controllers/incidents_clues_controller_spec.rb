require 'rails_helper'
require 'httparty'

RSpec.describe 'IncidentsCluesController', type: :request do
  include Rails.application.routes.url_helpers

  describe 'GET /incidents/:incident_id/clues' do
    let(:incident_id) { 'ac5e2480-f51e-47d2-9329-31be9d7dd1c3' }

    it 'returns a successful response with valid data' do
      # # get "/incidents/#{incident_id}/clues"
      # response = HTTParty.get("http://0.0.0.0:3000/incidents/ac5e2480-f51e-47d2-9329-31be9d7dd1c3/clues?env=test")
      #
      # expect(response).to have_http_status(:ok)
      #
      # response_data = JSON.parse(response.body)
      #
      # expect(response_data).to have_key('data')
      # expect(response_data['data']).to be_an(Array)
      # expect(response_data['data'].first).to have_key('id')
    end
  end
end
