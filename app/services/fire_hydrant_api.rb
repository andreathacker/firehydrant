require "httparty"

API_URL = "https://api.firehydrant.io/v1/"

class FireHydrantApi
  def initialize(http_client: HTTParty)
    @http_client = http_client
  end

  def self.build
    FireHydrantApi.new
  end

  def get_incident_events(incident_id)
    # TODO: Add error handling
    response = @http_client.get(
      "#{API_URL}/incidents/#{incident_id}/events",
      headers: { "Authorization" => ENV["FIRE_HYDRANT_API_KEY"] }
    )
    response.parsed_response
  end
end

# f = Services::FireHydrantApi.new
# f.get_incident_events("ac5e2480-f51e-47d2-9329-31be9d7dd1c3")
