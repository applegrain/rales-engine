class Api::V1::MerchantsController < Api::V1::BaseController
  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    value = find_params.values.first
    term = find_params.keys.first

    respond_with Merchant.find_by(term => value)
  end

  def find_all
    value = find_params.values.first
    term = find_params.keys.first

    respond_with Merchant.where(term => value)
  end

  def random
    value = rand(Merchant.count)
    respond_with Merchant.find(value)
  end

  private

  def find_params
    params.permit(:id, :name)
  end

end
