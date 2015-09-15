class Api::V1::ItemsController < Api::V1::BaseController
  def show
    respond_with Item.find(params[:id])
  end

  def find
    value = find_params.values.first
    term = find_params.keys.first

    respond_with Item.find_by(term => value)
  end

  def find_all
    value = find_params.values.first
    term = find_params.keys.first

    respond_with Item.where(term => value)
  end

  def random
    value = rand(Item.count)
    respond_with Item.find(value)
  end

  private

  def find_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end
