class Api::V1::CustomersController < Api::V1::BaseController
  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    respond_with Customer.find_by(find_params)
  end

  def find_all
    respond_with Customer.where(find_params)
  end

  def random
    respond_with Customer.limit(1).order("RANDOM()")
  end

  def invoices
    respond_with Customer.find_by(id: find_params[:customer_id]).invoices
  end

  def transactions
    respond_with Customer.find_by(id: find_params[:customer_id]).transactions
  end

  def favorite_merchant
    respond_with Customer.find_by(id: find_params[:customer_id]).favorite_merchant
  end

  private

  def find_params
    params.permit(:id,
                  :first_name,
                  :last_name,
                  :customer_id,
                  :updated_at,
                  :created_at)
  end

end
