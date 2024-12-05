require "httparty"

API_URL = "https://api.firehydrant.io/v1"

class FireHydrantApi
  def initialize(http_client: HTTParty)
    @http_client = http_client
  end

  def self.build
    FireHydrantApi.new
  end

  def get_incident_events(incident_id)
    url = "#{API_URL}/incidents/#{incident_id}/events"
    response = @http_client.get(
      url,
      headers: { "Authorization" => ENV["FIRE_HYDRANT_API_KEY"] }
    )

    unless response.success?
      raise "Request failed - code: #{response.code}, body: #{response.body}"
    end

    log_success(response, url)
    response.parsed_response
  rescue => e
    log_error(e, url)
    raise e
  end

  def log_success(response, url)
    Rails.logger.info(
      {
        tag: self.class.name,
        response: response,
        url: url,
        message: "Request success"
      }
    )
  end

  def log_error(error, url)
    Rails.logger.warn(
      {
        tag: self.class.name,
        error: error,
        url: url,
        message: "Failed to make request"
      }
    )
  end
end
