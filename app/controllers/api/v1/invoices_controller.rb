class Api::V1::InvoicesController < Api::V1::BaseController
  def show
    respond_with Invoice.find(params[:id])
  end

  def find
    value = find_params.values.first
    term = find_params.keys.first

    respond_with Invoice.find_by(term => value)
  end

  def find_all
    value = find_params.values.first
    term = find_params.keys.first

    respond_with Invoice.where(term => value)
  end

  def random
    value = rand(Invoice.count)
    respond_with Invoice.find(value)
  end

  private

  def find_params
    params.permit(:id, :status, :merchant_id, :customer_id)
  end
end
