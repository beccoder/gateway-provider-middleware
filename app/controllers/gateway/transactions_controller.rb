class Gateway::TransactionsController < ApplicationController
  def create
    provider = ProviderClient.new

    provider_response = provider.init_transaction(transaction_params) # calling init method of provider service

    transaction_id = provider_response.dig(:body, "transaction_id")

    redirect_url = "#{request.base_url}/transactions/auth/#{transaction_id}"

    render json: { redirect_url: redirect_url }, status: :ok
  end

  private

  def transaction_params
    params.permit(:amount, :currency, :id)
  end
end
