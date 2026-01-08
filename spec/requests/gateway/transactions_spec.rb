require "rails_helper"

RSpec.describe "Gateway::Transactions", type: :request do
  it "returns redirect_url from provider transaction_id" do
    stub_request(:post, "https://provider.example.com/transactions/init")
      .to_return(
        status: 200,
        body: { transaction_id: "123", status: "pending" }.to_json
      )

    post "/gateway/transactions", params: {
      amount: 1000,
      currency: "EUR",
      id: "unique_id"
    }

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["redirect_url"])
      .to eq("http://www.example.com/transactions/auth/123")
  end
end
