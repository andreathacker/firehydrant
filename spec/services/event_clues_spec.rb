require 'rails_helper'

RSpec.describe EventClues, type: :service do
  let(:fire_hydrant_api) { instance_double(FireHydrantApi) }
  let(:clue_model) { class_double(Clue) }
  let(:event_clues) { EventClues.new(fire_hydrant_api: fire_hydrant_api, clue_model: clue_model) }

  describe '#add_clue' do

    context 'when incident_id is blank' do
      it 'returns an error response' do
        incident_id = nil
        event_id = 'event-1-2-3'

        response, status = event_clues.add_clue(incident_id, event_id)

        expect(response).to eq({ error: 'Invalid incident_id' })
        expect(status).to eq(:bad_request)
      end
    end

    context 'when event_id is blank' do
      it 'returns an error response' do
        incident_id = '1-1-1-1'
        event_id = nil

        response, status = event_clues.add_clue(incident_id, event_id)

        expect(response).to eq({ error: 'Invalid event_id' })
        expect(status).to eq(:bad_request)
      end
    end

    context 'when create! raises an error' do
      it 'logs the error and returns a server error response' do
        incident_id = '1-1-1-1'
        event_id = 'event-1-2-3'
        allow(clue_model).to receive(:create!).and_raise(StandardError.new('Something went wrong'))
        expect(Rails.logger).to receive(:error).with(instance_of(StandardError))

        response, status = event_clues.add_clue(incident_id, event_id)

        expect(response).to eq({ error: 'Internal server error' })
        expect(status).to eq(:internal_server_error)
      end
    end

    context 'when the clue is successfully created' do
      it 'returns the clue data and status ok' do
        incident_id = '1-1-1-1'
        event_id = 'event-1-2-3'
        clue = instance_double(Clue, id: 1, incident_id: incident_id, event_id: event_id)
        allow(clue_model).to receive(:create!).with(incident_id: incident_id, event_id: event_id).and_return(clue)

        response, status = event_clues.add_clue(incident_id, event_id)

        expect(response).to eq({ id: 1, incident_id: incident_id, event_id: event_id })
        expect(status).to eq(:ok)
      end
    end
  end
end
