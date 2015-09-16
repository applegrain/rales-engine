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

  def self.total_revenue_by_date(date)
    { total_revenue: Invoice.all.where({created_at: date}).successful.joins(:invoice_items).sum("quantity * unit_price") }
  end

  def self.ranked_by_total_revenue(quantity)
    values = Merchant.all.map do |merchant|
      [merchant, merchant.invoices.successful.joins(:invoice_items).sum("quantity * unit_price")]
    end
      .sort_by { |pair| -pair.last }.map(&:first).first(quantity.to_i)
  end
end
