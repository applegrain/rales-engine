class Api::V1::TransactionsController < Api::V1::BaseController
  def show
    respond_with Transaction.find(params[:id])
  end

  def find
    value = find_params.values.first
    term = find_params.keys.first

    respond_with Transaction.find_by(term => value)
  end

  def find_all
    value = find_params.values.first
    term = find_params.keys.first

    respond_with Transaction.where(term => value)
  end

  def random
    value = rand(Transaction.count)
    respond_with Transaction.find(value)
  end

  private

  def find_params
    params.permit(:id, :credit_card_number, :result, :invoice_id)
  end
end
