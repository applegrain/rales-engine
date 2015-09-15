class Api::V1::CustomersController < Api::V1::BaseController
  def show
    respond_with Customer.find(params[:id])
  end

  def find
    value = find_params.values.first
    term = find_params.keys.first

    respond_with Customer.find_by(term => value)
  end

  def find_all
    value = find_params.values.first
    term = find_params.keys.first

    respond_with Customer.where(term => value)
  end

  def random
    value = rand(Customer.count)
    respond_with Customer.find(value)
  end

  private

  def find_params
    params.permit(:id, :first_name, :last_name)
  end

end