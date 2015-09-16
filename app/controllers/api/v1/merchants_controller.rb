class Api::V1::MerchantsController < Api::V1::BaseController
  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
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

  def all_merchants_revenue
    respond_with Merchant.total_revenue_by_date(find_params[:date])
  end

  def most_revenue
    respond_with Merchant.ranked_by_total_revenue(find_params[:quantity])
  end

  def customers_with_pending_invoices
    respond_with Merchant.find_by(id: find_params[:merchant_id]).customers_with_pending_invoices
  end

  def favorite_customer
    respond_with Merchant.find_by(id: find_params[:merchant_id]).favorite_customer
  end

  private

  def find_params
    params.permit(:id,
                  :name,
                  :merchant_id,
                  :date,
                  :created_at,
                  :updated_at,
                  :quantity)
  end

end
