class Api::V1::ItemsController < Api::V1::BaseController
  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end

  def find
    respond_with Item.where(find_params).first
  end

  def find_all
    respond_with Item.where(find_params)
  end

  def random
    respond_with Item.limit(1).order("RANDOM()")
  end

  def invoice_items
    respond_with Item.find_by(id: find_params[:item_id]).invoice_items
  end

  def merchant
    respond_with Item.find_by(id: find_params[:item_id]).merchant
  end

  def best_day
    respond_with Item.find_by(id: find_params[:item_id]).best_day
  end

  def most_items
    respond_with Item.most_items(params[:quantity])
  end

  def most_revenue
    respond_with Item.most_revenue(find_params[:quantity])
  end

  private

  def find_params
    params.permit(:id,
                  :name,
                  :description,
                  :unit_price,
                  :merchant_id,
                  :item_id,
                  :created_at,
                  :updated_at,
                  :quantity)
  end
end
