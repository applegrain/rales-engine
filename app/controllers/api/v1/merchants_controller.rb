class Api::V1::MerchantsController < Api::V1::BaseController
  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    respond_with Merchant.find_by(find_params)
  end

  def find_all
    respond_with Merchant.where(find_params)
  end

  def random
    respond_with Merchant.limit(1).order("RANDOM()")
  end

  def items
    respond_with Merchant.find_by(id: find_params[:merchant_id]).items
  end

  def invoices
    respond_with Merchant.find_by(id: find_params[:merchant_id]).invoices
  end

  def revenue
    respond_with Merchant.find_by(id: find_params[:merchant_id]).revenue(find_params)
  end

  private

  def find_params
    params.permit(:id,
                  :name,
                  :merchant_id,
                  :date)
  end

end
