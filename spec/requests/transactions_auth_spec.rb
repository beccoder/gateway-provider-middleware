require "rails_helper"

RSpec.describe "Transactions auth", type: :request do
  it "renders success when provider authorizes" do
    stub_request(:put, "https://provider.example.com/transactions/auth/123")
      .to_return(
        status: 200,
        body: { status: "success" }.to_json
      )

    get "/transactions/auth/123"

    expect(response.body).to eq("success")
  end

  it "renders failed when provider fails" do
    stub_request(:put, "https://provider.example.com/transactions/auth/123")
      .to_return(
        status: 400,
        body: { status: "failed" }.to_json
      )

    get "/transactions/auth/123"

    expect(response.body).to eq("failed")
  end
end
