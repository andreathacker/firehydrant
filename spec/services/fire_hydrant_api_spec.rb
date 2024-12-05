require "rails_helper"

RSpec.describe FireHydrantApi, type: :model do
  let(:http_client) { class_double("HTTParty") }
  let(:fire_hydrant_api) { FireHydrantApi.new(http_client: http_client) }
  let(:incident_id) { "12345" }

  describe "#get_incident_events" do
    context "when the request is successful" do
      let(:response) do
        instance_double("HTTParty::Response", success?: true, code: 200, body: "Success", parsed_response: { "event" => "mock event" })
      end

      before do
        allow(http_client).to receive(:get).and_return(response)
        allow(Rails.logger).to receive(:info)
      end

      it "executes the success code path" do
        fire_hydrant_api.get_incident_events(incident_id)

        expect(Rails.logger).to have_received(:info)
      end
    end

    context "when the request fails" do
      let(:response) do
        instance_double("HTTParty::Response", success?: false, code: 400, body: "Bad Request", parsed_response: nil)
      end

      before do
        allow(http_client).to receive(:get).and_return(response)
        allow(Rails.logger).to receive(:warn)
      end

      it "executes the error handling code path" do
        expect {
          fire_hydrant_api.get_incident_events(incident_id)
        }.to raise_error("Request failed - code: 400, body: Bad Request")

        expect(Rails.logger).to have_received(:warn)
      end
    end
  end
end
