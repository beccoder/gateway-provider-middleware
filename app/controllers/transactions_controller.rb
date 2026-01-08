class TransactionsController < ApplicationController
  def auth
    provider = ProviderClient.new
    response = provider.authorize_transaction(params[:id])

    if response[:status] == 200 && response.dig(:body, "status") == "success"
      render plain: "success", status: :ok
    else
      render plain: "failed", status: :unprocessable_entity
    end
  end
end
