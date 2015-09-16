class Api::V1::TransactionsController < Api::V1::BaseController
  def index
  respond_with Transaction.all
  end

  def show
    respond_with Transaction.find(params[:id])
  end

  def find
    respond_with Transaction.find_by(find_params)
  end

  def find_all
    respond_with Transaction.where(find_params)
  end

  def random
    respond_with Transaction.limit(1).order("RANDOM()")
  end

  def invoice
    respond_with Transaction.find_by(id: find_params[:transaction_id]).invoice
  end

  private

  def find_params
    params.permit(:id,
                  :credit_card_number,
                  :result,
                  :invoice_id,
                  :transaction_id,
                  :created_at,
                  :updated_at)
  end
end
