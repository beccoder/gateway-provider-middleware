require "net/http"
require "uri"
require "json"

class ProviderClient
  PROVIDER_BASE_URL = "https://provider.example.com"

  def init_transaction(payload)
    uri = URI("#{PROVIDER_BASE_URL}/transactions/init")
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request.body = payload.to_json

    perform_request(uri, request)
  end

  def authorize_transaction(transaction_id)
    uri = URI("#{PROVIDER_BASE_URL}/transactions/auth/#{transaction_id}")
    request = Net::HTTP::Put.new(uri)

    perform_request(uri, request)
  end

  private

  def perform_request(uri, request)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    {
      status: response.code.to_i,
      body: response.body.present? ? JSON.parse(response.body) : {}
    }
  end
end
