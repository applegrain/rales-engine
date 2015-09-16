class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def customers_with_pending_invoices
    invoices.pending.joins(:customer).uniq
  end

  def revenue(params)
    if params[:date]
      revenue_by_date(params[:date])
    else
      { revenue: invoices.successful.joins(:invoice_items).sum("quantity * unit_price") }
    end
  end

  def revenue_by_date(date)
    { revenue: invoices.where({created_at: date}).successful.joins(:invoice_items).sum("quantity * unit_price") }
  end

  def favorite_customer
    id = invoices.successful.group_by(&:customer_id).sort_by { |k, v| v.count }.reverse.flatten.first
    Customer.find_by(id: id)
  end

  def self.total_revenue_by_date(date)
    { total_revenue: Invoice.all.where({created_at: date}).successful.joins(:invoice_items).sum("quantity * unit_price") }
  end

  def self.ranked_by_total_revenue(quantity)
    values = Merchant.all.map do |merchant|
      [merchant, merchant.invoices.successful.joins(:invoice_items).sum("quantity * unit_price")]
    end
      .sort_by { |pair| -pair.last }.map(&:first).first(quantity.to_i)
  end

  def self.ranked_by_total_items_sold(quantity)
    values = Merchant.all.map do |merchant|
      [merchant, merchant.invoices.successful.joins(:invoice_items).sum(:quantity)]
    end
      .sort_by { |pair| -pair.last }.map(&:first).first(quantity.to_i)
  end
end
