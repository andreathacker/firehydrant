require 'rails_helper'

RSpec.describe IncidentClues, type: :service do
  let(:fire_hydrant_api) { instance_double(FireHydrantApi) }
  let(:clue_model) { class_double(Clue) }
  let(:incident_clues) { IncidentClues.new(fire_hydrant_api: fire_hydrant_api, clue_model: clue_model) }

  describe '#list_clues' do
    context 'when incident_id is blank' do
      it 'returns an error response' do
        incident_id = nil

        response, status = incident_clues.list_clues(incident_id)

        expect(response).to eq({ error: 'Invalid incident_id' })
        expect(status).to eq(:bad_request)
      end
    end

    context 'when get_incident_events throws an error' do
      it 'logs the error and returns a server error response' do
        incident_id = '1-1-1-1'
        allow(fire_hydrant_api).to receive(:get_incident_events).and_raise(StandardError.new('Something went wrong'))
        expect(Rails.logger).to receive(:error).with(instance_of(StandardError))

        response, status = incident_clues.list_clues(incident_id)

        expect(response).to eq({ error: 'Internal server error' })
        expect(status).to eq(:internal_server_error)
      end
    end

    context 'when the request succeeds' do
      it 'returns the clues for the incident' do
        incident_id = '1-1-1-1'
        incident_events = [
          { id: "event-1-2-3" },
          { id: "event-2-3-4" }
        ]
        allow(fire_hydrant_api).to receive(:get_incident_events).with(incident_id).and_return({ "data" => incident_events })
        allow(clue_model).to receive(:exists?).and_return(true)

        response, status = incident_clues.list_clues(incident_id)

        expect(response).to eq({ data: incident_events })
        expect(status).to eq(:ok)
      end
    end
  end

  describe '#create_clue' do
    context 'when incident_id is blank' do
      it 'returns an error response' do
        incident_id = nil
        body = { some: 'data' }

        response, status = incident_clues.create_clue(incident_id, body)

        expect(response).to eq({ error: 'Invalid incident_id' })
        expect(status).to eq(:bad_request)
      end
    end

    context 'when body is blank' do
      it 'returns an error response' do
        incident_id = '1-1-1-1'
        body = nil

        response, status = incident_clues.create_clue(incident_id, body)

        expect(response).to eq({ error: 'Invalid body' })
        expect(status).to eq(:bad_request)
      end
    end

    context 'when create_event throws an error' do
      it 'logs the error and returns a server error response' do
        incident_id = '1-1-1-1'
        body = { clue: 'data' }
        allow(fire_hydrant_api).to receive(:create_event).and_raise(StandardError.new('Something went wrong'))
        expect(Rails.logger).to receive(:error).with(instance_of(StandardError))

        response, status = incident_clues.create_clue(incident_id, body)

        expect(response).to eq({ error: 'Internal server error' })
        expect(status).to eq(:internal_server_error)
      end
    end

    context 'when the request succeeds' do
      it 'returns the response from the fire_hydrant_api' do
        incident_id = '1-1-1-1'
        body = { clue: 'data' }
        response_from_api = { success: true }
        allow(fire_hydrant_api).to receive(:create_event).with(incident_id, body).and_return(response_from_api)

        response, status = incident_clues.create_clue(incident_id, body)

        expect(response).to eq(response_from_api)
        expect(status).to eq(:ok)
      end
    end
  end

end
